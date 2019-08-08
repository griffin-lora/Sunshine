-- TrafficConeGod

return function(Sunshine, entity)
    local prefab = entity.prefab
    if prefab then
        prefab.originalPrefab = prefab.prefab
        prefab.prefab = require(prefab.prefab)
        for name, component in pairs(prefab.prefab) do
            if not entity[name] then
                entity[name] = Sunshine:cloneTable(component)
            end
        end
        if prefab.prefab.core then
            entity.core.id = prefab.prefab.core.id
        end
        entity.core.active = true
    end
end