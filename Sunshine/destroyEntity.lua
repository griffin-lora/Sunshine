return function(_, entity)
    entity.core.active = false
    for index, checkEntity in pairs(entity.core.scene.entities) do
        if checkEntity == entity then
            table.remove(entity.core.scene.entities, index)
        end
    end
    for _, instance in pairs(entity.core.instances) do
        instance:Destroy()
    end
    for _, connection in pairs(entity.core.connections) do
        connection:Disconnect()
    end
    entity.core.updateCallbacks = {}
    entity.core.instances = {}
    entity.core.connections = {}
end