return function(Sunshine, scene, ...)
    Sunshine.loadingScene = true
    if not Sunshine.callOrder then
        local callOrder = {}
        for fullName, system in pairs(Sunshine.systems) do
            local split = fullName:split("_")
            local index = tonumber(split[1])
            local name = split[2]
            callOrder[index] = system
        end
        Sunshine.callOrder = callOrder
    end
    for index, callback in pairs(Sunshine.sceneLoadCallbacks) do
        callback[1](scene, ...)
    end
    if Sunshine.loadingScene then
        Sunshine:unloadScene()
        Sunshine.dataScene = scene
        Sunshine.scene = {entities = {}}
        Sunshine.loadingScene = false
        for _, entity in pairs(scene.entities) do
            Sunshine:createEntity(entity)
        end
    end
end