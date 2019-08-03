return function(_, entity)
    local destroying = true
    for _, callback in pairs(entity.core.entityDestroyCallbacks) do
        if callback() == false then
            destroying = false
        end
    end
    if destroying then
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
    end
end