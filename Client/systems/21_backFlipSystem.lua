local state = "backFlip"

local VECTOR3_NEW = Vector3.new

return function(Sunshine, entity)
    local component = entity[state]
    local character = entity.character
    local input = entity.input
    local transform = entity.transform
    local physics = entity.physics
    local animator = entity.animator
    local speaker = entity.speaker
    Sunshine:createStateSystem(entity, state, function()
        -- start check
        return character.state == "crouch" and physics.velocity.Magnitude < 13 and character.grounded and input.space
    end, function()
        -- start
        local horizontal = transform.cFrame.LookVector * component.backPower
        physics.velocity = VECTOR3_NEW(horizontal.X, component.power, horizontal.Z)
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
    end)
end