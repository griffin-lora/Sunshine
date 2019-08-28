local state = "groundPoundJump"

local VECTOR3_NEW = Vector3.new

return function(Sunshine, entity)
    local component = entity[state]
    local character = entity.character
    local input = entity.input
    local physics = entity.physics
    local animator = entity.animator
    local spaceTick
    local lastSpace
    Sunshine:createStateSystem(entity, state, function()
        -- start check
        return character.state == "groundPound" and character.grounded and spaceTick and
        entity.core.tick - spaceTick < 0.1
    end, function()
        -- start
        physics.velocity = VECTOR3_NEW(0, component.power, 0)
        animator.action = component.animation
    end, function()
        -- update
    end, function()
        -- end check
        return character.grounded or character.swimming
    end, function()
        -- end
        if character.state == state then
            animator.action = nil
        end
    end, function()
        if input.space and not lastSpace then
            spaceTick = entity.core.tick
        end
        lastSpace = input.space
    end)
end