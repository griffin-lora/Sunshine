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
        local lastSaveTick = Sunshine:tick(scene)
        Sunshine:update(function()
            if (Sunshine:tick(scene) - lastSaveTick) > 20 then
                lastSaveTick = Sunshine:tick(scene)
                Sunshine:fireServer("saving", entity.core.id, store.save)
            end
        end, entity)
    end
end