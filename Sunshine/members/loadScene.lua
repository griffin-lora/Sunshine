return function(Sunshine, scene, sceneIndex, ...)
    sceneIndex = sceneIndex or 1
    Sunshine.loadingScene = true
    if not Sunshine.callOrder then
        local callOrder = {}
        for fullName, system in pairs(Sunshine.systems) do
            local split = fullName:split("_")
            local index = tonumber(split[1])
            callOrder[index] = system
        end
        Sunshine.callOrder = callOrder
    end
    local loading = true
    for _, callback in pairs(Sunshine.sceneLoadCallbacks) do
        local callbackScene = Sunshine.entityScenes[callback[2]]
        if callbackScene and not callbackScene.paused then
            if callback[1](scene, sceneIndex, ...) == false then
                loading = false
            end
        end
    end
    if loading then
        Sunshine:unloadScene(Sunshine.scenes[sceneIndex])
        Sunshine.dataScene = scene
        Sunshine.scenes[sceneIndex] = {entities = {}, paused = false}
        Sunshine.loadingScene = false
        for _, entity in pairs(scene.entities) do
            Sunshine:createEntity(entity, Sunshine.scenes[sceneIndex])
        end
    end
end