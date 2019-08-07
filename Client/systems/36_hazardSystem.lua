return function(Sunshine, entity)
    local hazard = entity.hazard
    local collider = entity.collider
    if hazard and collider then
        Sunshine:update(function()
            for _,hitEntity in pairs(collider.hitEntities) do
                if hitEntity and hitEntity.health and not hitEntity.health.invulnerable then
                    hitEntity.health.invulnerable = true
                    hitEntity.health.health = hitEntity.health.health - hazard.damage
                end
            end
        end, entity)
    end
end