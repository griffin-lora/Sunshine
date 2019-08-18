local state = "longJump"

local VECTOR3_NEW = Vector3.new

return function(Sunshine, entity)
    local component = entity[state]
    local character = entity.character
    local input = entity.input
    local transform = entity.transform
    local physics = entity.physics
    local animator = entity.animator
    local speaker = entity.speaker
    local spaceTick
    local lastSpace
    Sunshine:createStateSystem(entity, state, function()
        -- start check
        return character.state == "crouch" and spaceTick and entity.core.tick - spaceTick < 0.1 and
        VECTOR3_NEW(physics.velocity.X, 0, physics.velocity.Z).Magnitude >= 13
    end, function()
        -- start
        spaceTick = nil
        local horizontal = transform.cFrame.LookVector * component.power
        physics.velocity = VECTOR3_NEW(horizontal.X, component.bouncePower, horizontal.Z)
        animator.action = component.animation
        if component.sound then
            speaker.id = component.sound
            speaker.playing = true
        end
    end, function()
        -- update
    end, function()
        -- end check
        return character.grounded or character.swimming
    end, function()
        -- end
        if character.state == state then
            animator.action = nil
        end
    end, function()
        if input.space and not lastSpace then
            spaceTick = entity.core.tick
        end
        lastSpace = input.space
    end)
end