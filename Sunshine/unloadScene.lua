return function(Sunshine, scene)
    Sunshine.scenes[scene.index] = nil
    for _, entity in pairs(scene.entities) do
        Sunshine:destroyEntity(entity)
    end
end