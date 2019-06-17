return function(Sunshine, entity)
    local hazard = entity.hazard
    local collider = entity.collider
    if hazard and collider then
        Sunshine:update(function()
            if collider.hitEntity and collider.hitEntity.health then
                collider.hitEntity.health.health = collider.hitEntity.health.health - hazard.damage
            end
        end, entity)
    end
end