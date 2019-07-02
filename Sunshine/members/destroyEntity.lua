return function(Sunshine, entity)
    local destroying = true
    for index, callback in pairs(Sunshine.entityDestroyCallbacks) do
        if callback[2] == entity then
            if callback[1]() == false then
                destroying = false
            else
                Sunshine.entityDestroyCallbacks[index] = nil
            end            
        end
    end
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