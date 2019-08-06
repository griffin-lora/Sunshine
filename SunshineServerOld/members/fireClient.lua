return function(Sunshine, player, ...)
    local remoteEvent = Sunshine.remoteEvent
    remoteEvent:FireClient(player, ...)
end