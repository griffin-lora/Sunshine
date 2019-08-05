local state = "bounce"

return function(Sunshine, entity)
    local component = entity[state]
    local character = entity.character
    local physics = entity.physics
    local speaker = entity.speaker
    local animator = entity.animator
    Sunshine:createStateSystem(entity, state, function()
        -- start check
        return false
    end, function()
        -- start
        character.canLoseMagnitude = true
        physics.velocity = Vector3.new(0, component.power, 0)
        if not character.grounded then
            component.bounceCount = component.bounceCount + 1
        end
        animator.action = 2504812300            
        if component.sound then
            speaker.id = component.sound
            speaker.playing = true
        end
    end, function()
        -- update
        character.canLoseMagnitude = false
    end, function()
        -- end check
        return character.grounded
    end, function()
        -- end
        if character.state == state then
            animator.action = nil
        end
    end, function()
        if character.grounded then
            component.bounceCount = 0
        end
    end)
end