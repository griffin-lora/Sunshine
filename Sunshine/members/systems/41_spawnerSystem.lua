return function(Sunshine, entity, scene)
    local spawner = entity.spawner
    if spawner then
        Sunshine:update(function()
            if spawner.active then
                local entityClone = Sunshine:copyTable(Sunshine:getEntity(spawner.entity))
                entityClone.core.active = true
                Sunshine:createEntity(entityClone, scene)
                spawner.active = false
            end
        end, entity)
    end
end