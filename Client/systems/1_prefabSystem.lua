-- TrafficConeGod

return function(Sunshine, entity)
    local prefab = entity.prefab
    if prefab then
        prefab.prefab = require(prefab.prefab)
        for name, component in pairs(prefab.prefab) do
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
        if prefab.prefab.core then
            entity.core.id = prefab.prefab.core.id
        end
        entity.core.active = true
    end
end