return function(Sunshine, dataEntity, scene)
    if dataEntity.core then
        if dataEntity.core.active then
            local entity = Sunshine:cloneTable(dataEntity)
            entity.core.scene = scene
            entity.core.tick = 0
            entity.core.updateCallbacks = {}
            entity.core.instances = {}
            entity.core.connections = {}
            entity.core.sceneUnloadCallbacks = {}
            entity.core.entityDestroyCallbacks = {}
            entity.core.dataEntity = dataEntity
            scene.entities[#scene.entities + 1] = entity
            for _, system in ipairs(Sunshine.systems) do
                system(Sunshine, entity, scene)
            end
            return entity
        end
    else
        error("Entity does not have a core component.")
    end
end