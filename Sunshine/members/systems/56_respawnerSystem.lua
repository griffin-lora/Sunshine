return function(Sunshine, entity, scene)
    local respawner = entity.respawner
    local health = entity.health
    if respawner then
        local initialEntity = Sunshine:copyTable(Sunshine:getEntityById(entity.core.id,
        Sunshine.dataScenes[scene.index]))
        local startTick
        Sunshine:update(function()
            if not respawner.active then
                startTick = nil
            elseif not startTick then
                startTick = Sunshine:tick(scene)
            end
            if startTick and Sunshine:tick(scene) - startTick >= respawner.time or (health and health.health == 0) then
                Sunshine:destroyEntity(entity)
                Sunshine:createEntity(initialEntity, scene)
            end
        end, entity)
    end
end