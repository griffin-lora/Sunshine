-- TrafficConeGod

return function(Sunshine, entity)
    local store = entity.store
    if store then
        local DataStore2 = require(1936396537)
        Sunshine:addConnection(Sunshine.remoteEvent.OnServerEvent, function(player, reason, id, save)
            if reason == "saving" then
                local storage = DataStore2("store", player)
                local storageTable = storage:Get({})
                storageTable[id] = save
                storage:Set(storageTable)
            elseif reason == "loading" then
                local storage = DataStore2("store", player)
                local storedSave = storage:Get({})[id] or {}
                Sunshine:fireClient(player, id, storedSave)
            end
        end, entity)
    end
end