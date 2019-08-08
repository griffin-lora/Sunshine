local Selection = game:GetService("Selection")

return function(Sunshine, entity)
    local loader = entity.loader
    local button = entity.button
    if loader and button then
        Sunshine:update(function()
            if button.activated then
                for index, instance in pairs(Selection:Get()) do
                    if instance:IsA("ModuleScript") then
                        local dataScene = require(instance)
                        if type(dataScene) == "table" and dataScene.entities then
                            Sunshine:loadScene(dataScene, index + 1)
                        end
                    end
                end
            end
        end, entity)
    end
end