return function(Sunshine, entity)
    local bouncer = entity.bouncer
    local collider = entity.collider
    if bouncer and collider then
        Sunshine:update(function()
            for _,hitEntity in pairs(collider.hitEntities) do
                if hitEntity and hitEntity.character then
                    local physics = hitEntity.physics
                    if bouncer.direct then
                        physics.velocity = Vector3.new(0, bouncer.power, 0)
                    else
                        physics.velocity = Vector3.new(physics.velocity.X, bouncer.power, physics.velocity.Z)
                    end
                end
            end
        end, entity)
    end
end