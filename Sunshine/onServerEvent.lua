return function(Sunshine, callback)
    local remoteEvent = Sunshine.remoteEvent
    return remoteEvent.OnServerEvent:Connect(function(player, ...)
        local args = {...}
        local success, message = pcall(function()
            callback(player, unpack(args))
        end)
        if not success then
            player:Kick("dont try to pull that")
            warn(player, " caused error: ", message)
        end
    end)
end