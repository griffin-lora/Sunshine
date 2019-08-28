local state = "bonk"

return function(Sunshine, entity)
    local component = entity[state]
    local character = entity.character
    local transform = entity.transform
    local physics = entity.physics
    local animator = entity.animator
    local speaker = entity.speaker
    local horizontal
    local oldWalkSpeedFactor
    local startTick
    Sunshine:createStateSystem(entity, state, function()
        -- start check
        return (character.state == "dive" or character.state == "longJump") and not character.swimming and
        character.onWall and not character.grounded and character.controllable
    end, function()
        -- start
        startTick = entity.core.tick
        horizontal = transform.cFrame.LookVector * component.power
        physics.velocity = horizontal
        animator.action = component.animation
        oldWalkSpeedFactor = character.walkSpeedFactor
        character.walkSpeedFactor = component.walkSpeedFactor
        if component.sound then
            speaker.id = component.sound
            speaker.playing = true
        end
    end, function()
        -- update
        if entity.core.tick - startTick > 0.25 then
            animator.action = component.doAnimation
        end
        character.walkSpeedFactor = component.walkSpeedFactor
        physics.velocity = Vector3.new(horizontal.X, physics.velocity.Y, horizontal.Z)
    end, function()
        -- end check
        return character.grounded
    end, function()
        -- end
        character.walkSpeedFactor = oldWalkSpeedFactor
        if character.state == state then
            animator.action = nil
        end
    end)
end