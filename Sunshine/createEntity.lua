return function(Sunshine, dataEntity, scene)
    if dataEntity.core then
        local entity = Sunshine:cloneTable(dataEntity)
        entity.core.scene = scene
        entity.core.tick = 0
        entity.core.updateCallbacks = {}
        entity.core.instances = {}
        entity.core.connections = {}
        scene.entities[#scene.entities + 1] = entity
        for _, system in ipairs(Sunshine.systems) do
            system(Sunshine, entity, scene)
        end
    else
        error("Entity does not have a core component.")
    end
end