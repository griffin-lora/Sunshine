-- TrafficConeGod

local state = "groundPound"

return function(Sunshine, entity)
    local component = entity[state]
    local character = entity.character
    local input = entity.input
    local transform = entity.transform
    local physics = entity.physics
    local animator = entity.animator
    local startTick
    local startEndTick
    local lastShift = false
    Sunshine:createStateSystem(entity, state, function()
        -- start check
        return character.state ~= "dive" and not character.grounded and input.shift and not lastShift
    end, function()
        -- start
        physics.movable = false
        physics.velocity = Vector3.new()
        character.canLoseMagnitude = true
        startTick = tick()
        animator.action = component.startAnimation
    end, function()
        -- update
        if character.grounded then
            physics.movable = false
            if not startEndTick then
                startEndTick = tick()
                animator.action = component.endAnimation
            end
        elseif (tick() - startTick) > component.delay then
            physics.movable = true
            physics.velocity = Vector3.new(0, component.speed, 0)
            if animator.action ~= component.animation then
                animator.action = component.animation
            end
        end
    end, function()
        -- end check
        return startEndTick and ((tick() - startEndTick) > component.delay)
    end, function()
        -- end
        startTick = nil
        startEndTick = nil
        physics.movable = true
        character.canLoseMagnitude = false
        if character.state == state then
            physics.velocity = Vector3.new(0, 0, 0)
        end
    end, function()
        -- general update
        lastShift = input.shift
    end)
end