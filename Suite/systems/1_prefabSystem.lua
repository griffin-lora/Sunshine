-- TrafficConeGod

return function(Sunshine, entity)
    local prefab = entity.prefab
    if prefab then
        local prefabInstance = prefab.prefab:Clone()
        local dataPrefab = require(prefabInstance)
        for name, component in pairs(dataPrefab) do
            if not entity[name] then
                entity[name] = Sunshine:cloneTable(component)
            else
                for propertyName, propertyValue in pairs(component) do
                    if not entity[name][propertyName] then
                        entity[name][propertyName] = propertyValue
                    end
                end
            end
        end
        if dataPrefab.core then
            entity.core.id = dataPrefab.core.id
        end
        entity.core.active = true
    end
end