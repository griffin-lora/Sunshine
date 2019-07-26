return function(_, id, scene)
    for _, entity in pairs(scene.entities) do
        if entity.core.id == id then
            return entity
        end
    end
end