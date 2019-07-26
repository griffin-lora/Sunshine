return function(Sunshine, entity)
    local hazard = entity.hazard
    local collider = entity.collider
    if hazard and collider then
        Sunshine:update(function()
            if collider.hitEntity and collider.hitEntity.health and not collider.hitEntity.health.invulnerable then
                collider.hitEntity.health.invulnerable = true
                collider.hitEntity.health.health = collider.hitEntity.health.health - hazard.damage
            end
        end, entity)
    end
end