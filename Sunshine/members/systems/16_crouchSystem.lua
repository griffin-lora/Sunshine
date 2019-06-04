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
        return character.grounded and input.shift
    end, function()
        -- start
        character.walkSpeedFactor = component.walkSpeedFactor
    end, function()
        -- update
        character.walkSpeedFactor = component.walkSpeedFactor
    end, function()
        -- end check
        return not input.shift or not character.grounded
    end, function()
        -- end
        character.walkSpeedFactor = 1
    end)
end