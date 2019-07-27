-- TrafficConeGod

return function(Sunshine, entity)
    local store = entity.store
    if store then
        Sunshine:addConnection(Sunshine.remoteEvent.OnClientEvent, function(id, save)
            if entity.core.id == id then
                store.save = save
            end
        end, entity)
        Sunshine:fireServer("loading", entity.core.id)
        local lastSaveTick = entity.core.tick
        Sunshine:update(function()
            if (entity.core.tick - lastSaveTick) > 10 then
                lastSaveTick = entity.core.tick
                Sunshine:fireServer("saving", entity.core.id, store.save)
            end
        end, entity)
    end
end