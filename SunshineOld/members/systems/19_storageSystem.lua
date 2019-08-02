-- TrafficConeGod

return function(Sunshine, entity, scene)
    local store = entity.store
    if store then
        Sunshine:addConnection(Sunshine:onClientEvent(function(id, save)
            if entity.core.id == id then
                store.save = save
            end
        end), nil, entity)
        Sunshine:fireServer("loading", entity.core.id)
        local lastSaveTick = entity.core.tick
        Sunshine:update(function()
            if (entity.core.tick - lastSaveTick) > 20 then
                lastSaveTick = entity.core.tick
                Sunshine:fireServer("saving", entity.core.id, store.save)
            end
        end, entity)
    end
end