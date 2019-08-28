-- TrafficConeGod

local state = "groundPound"

local VECTOR3_NEW = Vector3.new
local BLANK_VECTOR3 = VECTOR3_NEW()

return function(Sunshine, entity)
    local component = entity[state]
    local character = entity.character
    local input = entity.input
    local physics = entity.physics
    local animator = entity.animator
    local startTick
    local startEndTick
    local lastShift = false
    Sunshine:createStateSystem(entity, state, function()
        -- start check
        return character.state ~= "dive" and character.state ~= "bonk" and not character.grounded and input.shift and not lastShift
    end, function()
        -- start
        physics.movable = false
        physics.velocity = BLANK_VECTOR3
        character.canLoseMagnitude = true
        startTick = entity.core.tick
        animator.action = component.startAnimation
    end, function()
        -- update
        if character.grounded then
            physics.movable = false
            if not startEndTick then
                startEndTick = entity.core.tick
                animator.action = component.endAnimation
            end
        elseif (entity.core.tick - startTick) > component.delay then
            physics.movable = true
            physics.velocity = VECTOR3_NEW(0, component.speed, 0)
            if animator.action ~= component.animation then
                animator.action = component.animation
            end
        end
    end, function()
        -- end check
        return startEndTick and ((entity.core.tick - startEndTick) > component.delay)
    end, function()
        -- end
        startTick = nil
        startEndTick = nil
        physics.movable = true
        character.canLoseMagnitude = false
        if character.state == state then
            physics.velocity = BLANK_VECTOR3
        end
    end, function()
        -- general update
        lastShift = input.shift
    end)
end