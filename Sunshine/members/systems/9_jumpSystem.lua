-- TrafficConeGod

local state = "jump"

return function(Sunshine, entity)
    local component = entity[state]
    local character = entity.character
    local input = entity.input
    local transform = entity.transform
    local physics = entity.physics
    local animator = entity.animator
    local groundedRemember = 0
    local lastSpace = false
    Sunshine:createStateSystem(entity, state, function()
        -- start check
        return character.state == nil and groundedRemember > 0 and input.space and not lastSpace
    end, function()
        -- start
        groundedRemember = 0
        physics.velocity = Vector3.new(physics.velocity.X, component.power, physics.velocity.Z)
        animator.action = component.animation
    end, function()
        -- update
        if physics.velocity.Y > 0 and not input.space then
            physics.velocity = Vector3.new(physics.velocity.X, physics.velocity.Y * 0.8, physics.velocity.Z)
        end
    end, function()
        -- end check
        return character.grounded
    end, function()
        -- end
        if character.state == state then
            animator.action = nil
        end
    end, function(step)
        -- general update
        lastSpace = input.space
        groundedRemember = groundedRemember - step
        if character.grounded then
            groundedRemember = 0.2
        end
    end)
end