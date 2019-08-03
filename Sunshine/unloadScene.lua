return function(Sunshine, scene)
    Sunshine.scenes[scene.index] = nil
    local entities = {}
    for _, entity in pairs(scene.entities) do
        entities[#entities + 1] = entity
    end
    for _, entity in pairs(entities) do
        Sunshine:destroyEntity(entity)
    end
end