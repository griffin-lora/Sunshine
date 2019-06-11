local state = "throw"

return function(Sunshine, entity)
    local component = entity[state]
    local character = entity.character
    local input = entity.input
    local transform = entity.transform
    local physics = entity.physics
    local animator = entity.animator
    local lastE = false
    Sunshine:createStateSystem(entity, state, function()
        -- start check
        return character.state ~= "groundPound" and character.state ~= "dive" and not character.grounded and input.e and not lastE
    end, function()
        -- start
        physics.velocity = Vector3.new(physics.velocity.X * 0.1, component.power, physics.velocity.Z * 0.1)
        animator.action = component.animation
    end, function()
        -- update
    end, function()
        -- end check
        return character.grounded
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