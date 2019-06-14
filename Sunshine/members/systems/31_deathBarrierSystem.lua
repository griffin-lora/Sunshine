return function(Sunshine, entity)
    local deathBarrier = entity.deathBarrier
    if deathBarrier then
        Sunshine:update(function()
            for _, entity in pairs(Sunshine.scene.entities) do
                local transform = entity.transform
                local health = entity.health
                if transform and health and transform.cFrame.y <= deathBarrier.y then
                    health.health = 0
                end
            end
        end)
    end
end