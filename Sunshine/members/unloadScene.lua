return function(Sunshine, scene)
    if scene then
        for _, entity in pairs(scene.entities) do
            Sunshine:destroyEntity(entity)
        end
    end
end