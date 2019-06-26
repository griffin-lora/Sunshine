-- TrafficConeGod

return function(Sunshine, entity)
    local prefab = entity.prefab
    if prefab then
        prefab.prefab = require(prefab.prefab)
        for name, component in pairs(prefab.prefab) do
            if name == "core" or not entity[name] then
                entity[name] = Sunshine:copyTable(component)
            end
        end
    end
end