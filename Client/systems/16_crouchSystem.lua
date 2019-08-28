-- TrafficConeGod

local state = "crouch"

return function(Sunshine, entity)
    local component = entity[state]
    local character = entity.character
    local input = entity.input
    local animator = entity.animator
    local oldWalkSpeedFactor = 1
    Sunshine:createStateSystem(entity, state, function()
        -- start check
        return not character.swimming and character.state == nil and character.grounded and input.shift
    end, function()
        -- start
        oldWalkSpeedFactor = character.walkSpeedFactor
        character.walkSpeedFactor = component.walkSpeedFactor
    end, function()
        -- update
        character.walkSpeedFactor = component.walkSpeedFactor
        if character.moving then
            if animator.action ~= component.moveAnimation then
                animator.action = component.moveAnimation
            end
        else
            if animator.action ~= component.animation then
                animator.action = component.animation
            end
        end
    end, function()
        -- end check
        return not input.shift or not character.grounded
    end, function()
        -- end
        character.walkSpeedFactor = oldWalkSpeedFactor
        if character.state == state then
            animator.action = nil
        end
    end)
end