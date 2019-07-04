return function(Sunshine)
    local DataStore2 = Sunshine.DataStore2
    Sunshine:onServerEvent(function(player, reason, id, save)
        if reason == "saving" then
            local storage = DataStore2("storage", player)
            local storageTable = storage:Get({})
            storageTable[id] = save
            storage:Set(storageTable)
        elseif reason == "loading" then
            local storage = DataStore2("storage", player)
            local storedSave = storage:Get({})[id] or {}
            Sunshine:fireClient(player, id, storedSave)
        end
    end)
end