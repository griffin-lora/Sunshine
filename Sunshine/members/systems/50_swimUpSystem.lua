local state = "swimUp"

return function(Sunshine, entity)
    local component = entity[state]
    local character = entity.character
    local input = entity.input
    local transform = entity.transform
    local physics = entity.physics
    local animator = entity.animator
    local lastSpace = false
    Sunshine:createStateSystem(entity, state, function()
        -- start check
        return character.swimming and input.space and not lastSpace
    end, function()
        -- start
        physics.velocity = Vector3.new(physics.velocity.X, component.power, physics.velocity.Z)
        animator.action = nil
    end, function()
        -- update
        if animator.action ~= component.animation then
            animator.action = component.animation
        end
    end, function()
        -- end check
        return true
    end, function()
        -- end
    end, function()
        -- general update
        lastSpace = input.space
    end)
end