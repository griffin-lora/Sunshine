return function(Sunshine, eventOrConnection, callback, entity)
    if not entity then
        warn("addConnection is being used without entity specification.")
    end
    if typeof(eventOrConnection) == "RBXScriptSignal" then
        Sunshine.connections[#Sunshine.connections + 1] = {eventOrConnection:Connect(function(...)
            if not Sunshine.paused then
                callback(...)
            end
        end), entity}
    elseif typeof(eventOrConnection) == "RBXScriptConnection" then
        Sunshine.connections[#Sunshine.connections + 1] = {eventOrConnection, entity}
    end
end