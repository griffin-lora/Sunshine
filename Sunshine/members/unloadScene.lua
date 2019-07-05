return function(Sunshine, scene)
    if scene then
        for _, entity in pairs(scene.entities) do
            if Sunshine.entityScenes[entity] == scene then
                Sunshine:destroyEntity(entity)
            end
        end
        -- for _, callback in pairs(Sunshine.entityDestroyCallbacks) do
        --     callback[1]()
        -- end
        -- Sunshine.entityDestroyCallbacks = {}
        -- Sunshine.updateCallbacks = {}
        -- Sunshine.sceneLoadCallbacks = {}
        -- for _, connection in pairs(Sunshine.connections) do
        --     connection[1]:Disconnect()
        -- end
        -- for _, instance in pairs(Sunshine.instances) do
        --     instance[1]:Destroy()
        -- end
        -- Sunshine.dataScene = nil
        -- Sunshine.scene = nil
    end
end