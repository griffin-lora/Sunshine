local state = "wallSlide"

return function(Sunshine, entity)
    local component = entity[state]
    local character = entity.character
    local transform = entity.transform
    local physics = entity.physics
    local animator = entity.animator
    local lastWall
    Sunshine:createStateSystem(entity, state, function()
        -- start check
        return not character.swimming and character.onWall and character.wall ~= lastWall and not character.grounded and
        Vector3.new(physics.velocity.X, 0, physics.velocity.Z).Magnitude > 1
    end, function()
        -- start
        lastWall = character.wall
        animator.action = component.animation
    end, function(step)
        -- update
        physics.velocity = Vector3.new(0, physics.velocity.Y, 0):Lerp(Vector3.new(0, component.speed, 0), step * 5)
        transform.cFrame = CFrame.new(transform.cFrame.Position, transform.cFrame.Position - character.wallNormal)
    end, function()
        -- end check
        return character.grounded or not character.onWall or character.swimming
    end, function()
        -- end
        if character.state == state then
            animator.action = nil
        end
    end, function()
        -- general update
        if character.grounded then
            lastWall = nil
        end
    end)
end