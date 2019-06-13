return function(Sunshine, event, callback, entity)
    if not entity then
        warn("addConnection is being used without entity specification.")
    end
    Sunshine.connections[#Sunshine.connections + 1] = {event:Connect(function(...)
        if not Sunshine.paused then
            callback(...)
        end
    end), entity}
end