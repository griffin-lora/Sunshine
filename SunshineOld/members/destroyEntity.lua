return function(Sunshine, entity, ...)
    local destroying = true
    for index, callback in pairs(Sunshine.entityDestroyCallbacks) do
        if callback[2] == entity then
            if callback[1](...) == false then
                destroying = false
            else
                table.remove(Sunshine.entityDestroyCallbacks, index)
            end
        end
    end
    if destroying then
        entity.core.active = false
        for index, callback in pairs(Sunshine.updateCallbacks) do
            if callback[2] == entity then
                table.remove(Sunshine.updateCallbacks, index)
            end
        end
        for index, callback in pairs(Sunshine.sceneLoadCallbacks) do
            if callback[2] == entity then
                table.remove(Sunshine.sceneLoadCallbacks, index)
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
        local scene = Sunshine.entityScenes[entity]
        for index, otherEntity in pairs(scene.entities) do
            if entity == otherEntity then
                scene.entities[index] = nil
            end
        end
        Sunshine.entityScenes[entity] = nil
    end
end