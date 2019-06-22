return function(Sunshine, entity)
    entity.core.active = false
    for index, callback in pairs(Sunshine.updateCallbacks) do
        if callback[2] == entity then
            Sunshine.updateCallbacks[index] = nil
        end
    end
    for index, callback in pairs(Sunshine.sceneLoadCallbacks) do
        if callback[2] == entity then
            Sunshine.sceneLoadCallbacks[index] = nil
        end
    end
    for _, connection in pairs(Sunshine.connections) do
        if connection[2] == entity then
            connection[1]:Disconnect()
        end
    end
    for _, instance in pairs(Sunshine.instances) do
        if instance[2] == entity then
            instance[1]:Destroy()
        end
    end
end