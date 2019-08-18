-- TrafficConeGod

local state = "tripleJump"

local VECTOR3_NEW = Vector3.new

return function(Sunshine, entity)
    local component = entity[state]
    local character = entity.character
    local input = entity.input
    local physics = entity.physics
    local animator = entity.animator
    local speaker = entity.speaker
    local spaceRemember = 0
    local lastSpace = false
    local jumpTick
    Sunshine:createStateSystem(entity, state, function()
        -- start check
        return not input.shift and not character.swimming and jumpTick and
        entity.core.tick - jumpTick <= component.time and
        VECTOR3_NEW(physics.velocity.X, 0, physics.velocity.Z).Magnitude > 30 and character.grounded and
        spaceRemember > 0
    end, function()
        -- start
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
        spaceRemember = spaceRemember - step
        if input.space and not lastSpace then
            spaceRemember = 0.1
        end
        lastSpace = input.space
        if character.state == "doubleJump" then
            jumpTick = entity.core.tick
        end
    end)
end