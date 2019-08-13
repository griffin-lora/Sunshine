local Selection = game:GetService("Selection")

return function(Sunshine, entity)
    local loader = entity.loader
    local button = entity.button
    if loader and button then
        local function loadScenes(scenes)
            local loadedScenes = {}
            for index, instance in pairs(scenes) do
                if instance:IsA("ModuleScript") then
                    local dataScene = require(instance)
                    if type(dataScene) == "table" and dataScene.entities then
                        local instanceClone = instance:Clone()
                        local dataSceneClone = require(instanceClone)
                        local scene = Sunshine:loadScene(dataSceneClone, index + 1)
                        scene.instance = instance
                        local path = {instance.Name}
                        local parent = instance.Parent
                        while parent ~= game do
                            path[#path + 1] = parent.Name
                            parent = parent.Parent
                        end
                        loadedScenes[index] = path
                        print("Loaded scene successfully!")
                    end
                end
            end
            Sunshine.plugin:SetSetting("loadedScenes_" .. game.PlaceId, loadedScenes)
        end
        local loadedScenes = Sunshine.plugin:GetSetting("loadedScenes_" .. game.PlaceId)
        if loadedScenes then
            local loadedSceneInstances = {}
            for sceneIndex, path in pairs(loadedScenes) do
                local instance = game
                for index = #path, 1, -1 do
                    instance = instance[path[index]]
                end
                loadedSceneInstances[sceneIndex] = instance
            end
            loadScenes(loadedSceneInstances)
        end
        Sunshine:update(function()
            if button.activated then
                loadScenes(Selection:Get())
            end
        end, entity)
    end
end