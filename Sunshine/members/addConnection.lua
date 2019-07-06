return function(Sunshine, eventOrConnection, callback, entity, ignorePause)
    if not entity then
        error("addConnection is being used without entity specification.")
    end
    if typeof(eventOrConnection) == "RBXScriptSignal" then
        Sunshine.connections[#Sunshine.connections + 1] = {eventOrConnection:Connect(function(...)
            local scene = Sunshine.entityScenes[entity]
            if scene and (not scene.paused or ignorePause) then
                callback(...)
            end
        end), entity}
    elseif typeof(eventOrConnection) == "RBXScriptConnection" then
        Sunshine.connections[#Sunshine.connections + 1] = {eventOrConnection, entity}
    end
end