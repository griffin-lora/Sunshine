return function(Sunshine, entity)
    for _, callback in pairs(Sunshine.updateCallbacks) do
        if callback[2] == entity then
            callback[1]:Disconnect()
        end
    end
    for _, connection in pairs(Sunshine.connections) do
        if connection[2] == entity then
            connection[1]:Disconnect()
        end
    end
    for _, instance in pairs(Sunshine.instances) do
        if instance[2] == entity then
            instance[1]:Disconnect()
        end
    end
end