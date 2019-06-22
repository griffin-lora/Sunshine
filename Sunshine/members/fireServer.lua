return function(Sunshine, ...)
    local remoteEvent = Sunshine.remoteEvent
    remoteEvent:FireServer(...)
end