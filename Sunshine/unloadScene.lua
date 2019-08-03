return function(Sunshine, scene)
    local unloading = true
    for _, entity in pairs(scene.entities) do
        for _, callback in pairs(entity.core.sceneUnloadCallbacks) do
            if callback() == false then
                unloading = false
            end
        end
    end
    if unloading then
        Sunshine.scenes[scene.index] = nil
        local entities = {}
        for _, entity in pairs(scene.entities) do
            entities[#entities + 1] = entity
        end
        for _, entity in pairs(entities) do
            Sunshine:destroyEntity(entity)
        end
    end
end