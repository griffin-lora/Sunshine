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
    local lastShift = false
    Sunshine:createStateSystem(entity, state, function()
        -- start check
        return character.state ~= "dive" and not character.grounded and input.shift and not lastShift
    end, function()
        -- start
        physics.movable = false
        startTick = tick()
        animator.action = 1146925487
    end, function()
        -- update
        if (tick() - startTick) > component.delay then
            physics.movable = true
            physics.velocity = Vector3.new(0, component.speed, 0)
            if animator.action ~= 1146924615 then
                animator.action = 1146924615
            end
        else
            physics.movable = false
        end
    end, function()
        -- end check
        return character.grounded
    end, function()
        -- end
        if character.state == state then
            physics.velocity = Vector3.new(0, 0, 0)
            physics.movable = true
            animator.action = nil
        end
    end, function()
        -- general update
        lastShift = input.shift
    end)
end