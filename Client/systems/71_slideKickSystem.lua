local state = "slideKick"

local VECTOR3_NEW = Vector3.new

return function(Sunshine, entity)
    local component = entity[state]
    local character = entity.character
    local input = entity.input
    local transform = entity.transform
    local physics = entity.physics
    local animator = entity.animator
    local speaker = entity.speaker
    local horizontal
    local startTick
    local lastE = false
    Sunshine:createStateSystem(entity, state, function()
        -- start check
        return not character.swimming and character.state == "crouch" and character.grounded and input.e and
        not lastE
    end, function()
        -- start
        startTick = entity.core.tick
        horizontal = transform.cFrame.LookVector * component.power
        physics.velocity = horizontal
        if component.sound then
            speaker.id = component.sound
            speaker.playing = true
        end
    end, function(step)
        -- update
        animator.action = component.animation
        horizontal = horizontal:Lerp(transform.cFrame.LookVector * component.power, step * 3)
        physics.velocity = VECTOR3_NEW(horizontal.X, physics.velocity.Y, horizontal.Z)
    end, function()
        -- end check
        return not character.grounded or character.swimming or entity.core.tick - startTick > component.time
    end, function()
        -- end
       	if character.state == state then
            animator.action = nil
        end
    end, function()
        -- general update
        lastE = input.e
    end)
end