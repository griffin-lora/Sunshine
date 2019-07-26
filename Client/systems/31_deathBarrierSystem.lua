return function(Sunshine, entity, scene)
    local deathBarrier = entity.deathBarrier
    if deathBarrier then
        Sunshine:update(function()
            for _, otherEntity in pairs(scene.entities) do
                local transform = otherEntity.transform
                local health = otherEntity.health
                if transform and health and transform.cFrame.y <= deathBarrier.y then
                    health.health = 0
                end
            end
        end, entity)
    end
end