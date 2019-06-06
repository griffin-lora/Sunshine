-- TrafficConeGod

local state = "crouch"

return function(Sunshine, entity)
    local component = entity[state]
    local character = entity.character
    local input = entity.input
    local transform = entity.transform
    local physics = entity.physics
    local animator = entity.animator
    Sunshine:createStateSystem(entity, state, function()
        -- start check
        return character.state == nil and character.grounded and input.shift
    end, function()
        -- start
        character.walkSpeedFactor = component.walkSpeedFactor
    end, function()
        -- update
        character.walkSpeedFactor = component.walkSpeedFactor
        if character.moving then
            if animator.action ~= 1156875985 then
                animator.action = 1156875985
            end
        else
            if animator.action ~= 1156846595 then
                animator.action = 1156846595
            end
        end
    end, function()
        -- end check
        return not input.shift or not character.grounded
    end, function()
        -- end
        character.walkSpeedFactor = 1
        if character.state == state then
            animator.action = nil
        end
    end)
end