return function(Sunshine, entity)
    local bouncer = entity.bouncer
    local collider = entity.collider
    if bouncer and collider then
        Sunshine:update(function()
            if collider.hitEntity and collider.hitEntity.tag and collider.hitEntity.tag.tag == "character" then
                local hitEntity = collider.hitEntity
                local physics = collider.hitEntity.physics
                print(physics.velocity)
                physics.velocity = Vector3.new(physics.velocity.X, bouncer.power, physics.velocity.Z)
            end
        end)
    end
end