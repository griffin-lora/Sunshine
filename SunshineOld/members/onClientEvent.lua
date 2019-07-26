return function(Sunshine, callback)
    local remoteEvent = Sunshine.remoteEvent
    return remoteEvent.OnClientEvent:Connect(function(...)
        callback(...)
    end)
end