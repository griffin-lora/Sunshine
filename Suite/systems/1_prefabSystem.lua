-- TrafficConeGod

return function(Sunshine, entity)
    local prefab = entity.prefab
    if prefab then
        -- local dataPrefab = require(prefab.prefab)
        -- for name, component in pairs(dataPrefab) do
        --     if not entity[name] then
        --         entity[name] = Sunshine:cloneTable(component)
        --     end
        -- end
        -- if dataPrefab.core then
        --     entity.core.id = dataPrefab.core.id
        -- end
        -- entity.core.active = true
    end
end