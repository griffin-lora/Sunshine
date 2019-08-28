-- TrafficConeGod

local state = "jump"

local VECTOR3_NEW = Vector3.new

return function(Sunshine, entity)
    local component = entity[state]
    local character = entity.character
    local input = entity.input
    local physics = entity.physics
    local animator = entity.animator
    local speaker = entity.speaker
    local spaceRemember = 0
    local groundedRemember = 0
    local lastSpace = false
    Sunshine:createStateSystem(entity, state, function()
        -- start check
        return not input.shift and not character.swimming and character.state == nil and groundedRemember > 0 and
        spaceRemember > 0
    end, function()
        -- start
        groundedRemember = 0
        spaceRemember = 0
        physics.velocity = VECTOR3_NEW(physics.velocity.X, component.power, physics.velocity.Z)
        animator.action = component.animation
        if component.sound then
            speaker.id = component.sound
            speaker.playing = true
        end
    end, function()
        -- update
        if physics.velocity.Y > 0 and not input.space then
            physics.velocity = VECTOR3_NEW(physics.velocity.X, physics.velocity.Y * 0.8, physics.velocity.Z)
        end
    end, function()
        -- end check
        return character.grounded or character.swimming
    end, function()
        -- end
        if character.state == state then
            animator.action = nil
        end
    end, function(step)
        -- general update
        groundedRemember = groundedRemember - step
        spaceRemember = spaceRemember - step
        if character.grounded then
            groundedRemember = 0.1
        end
        if input.space and not lastSpace then
            spaceRemember = 0.1
        end
        lastSpace = input.space
    end)
end