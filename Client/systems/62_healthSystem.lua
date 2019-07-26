return function(Sunshine, entity, scene)
    local health = entity.health
    if health then
        local startTick
        local lastInvulnerable = health.invulnerable
        Sunshine:update(function()
            if health.invulnerable and health.invulnerable ~= lastInvulnerable then
                startTick = Sunshine:tick(scene)
            end
            if health.invulnerable and Sunshine:tick(scene) - startTick > 2 then
                health.invulnerable = false
            end
            lastInvulnerable = health.invulnerable
        end, entity)
    end
end