-- TrafficConeGod

local state = "dive"

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
        return not character.swimming and character.state == "groundPound" and not character.grounded and input.e and
        not lastE
    end, function()
        -- start
        startTick = entity.core.tick
        physics.movable = true
        horizontal = transform.cFrame.LookVector * component.power
        physics.velocity = horizontal + VECTOR3_NEW(0, component.bouncePower, 0)
        animator.action = component.animation
        if component.sound then
            speaker.id = component.sound
            speaker.playing = true
        end
    end, function(step)
        -- update
        horizontal = horizontal:Lerp(transform.cFrame.LookVector * component.power, step * 3)
        physics.velocity = VECTOR3_NEW(horizontal.X, physics.velocity.Y, horizontal.Z)
        if entity.core.tick - startTick > 0.5 then
            animator.action = component.doAnimation
        end
    end, function()
        -- end check
        return character.grounded or character.swimming
    end, function()
        -- end
        if character.state ~= "bonk" then
            animator.action = component.endAnimation
        end
    end, function()
        -- general update
        lastE = input.e
    end)
end