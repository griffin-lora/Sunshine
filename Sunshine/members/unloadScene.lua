return function(Sunshine, scene)
    if scene then
        for _, entity in pairs(scene.entities) do
            if Sunshine.entityScenes[entity] == scene then
                Sunshine:destroyEntity(entity)
            end
        end
    end
end