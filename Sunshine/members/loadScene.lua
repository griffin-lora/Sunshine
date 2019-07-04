return function(Sunshine, scene, ...)
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
        if callback[1](scene, ...) == false then
            loading = false
        end
    end
    if loading then
        Sunshine:unloadScene()
        Sunshine.dataScene = scene
        Sunshine.scene = {entities = {}}
        Sunshine.loadingScene = false
        for _, entity in pairs(scene.entities) do
            Sunshine:createEntity(entity)
        end
    end
end