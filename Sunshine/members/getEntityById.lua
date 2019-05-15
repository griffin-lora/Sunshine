return function(Sunshine, id)
    if Sunshine.scene then
        for _, entity in pairs(Sunshine.scene.entities) do
            if entity.core.id == id then
                return entity
            end
        end
    end
end