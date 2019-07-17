return function(Sunshine, eventOrConnection, callback, entity, ignoreActive)
    if not entity then
        error("addConnection is being used without entity specification.")
    end
    if typeof(eventOrConnection) == "RBXScriptSignal" then
        Sunshine.connections[#Sunshine.connections + 1] = {eventOrConnection:Connect(function(...)
            local scene = Sunshine.entityScenes[entity]
            if scene and ((entity.core.active and scene.active) or ignoreActive) then
                callback(...)
            end
        end), entity}
    elseif typeof(eventOrConnection) == "RBXScriptConnection" then
        Sunshine.connections[#Sunshine.connections + 1] = {eventOrConnection, entity}
    end
end