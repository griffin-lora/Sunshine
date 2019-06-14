local state = "bounce"

return function(Sunshine, entity)
    local component = entity[state]
    local character = entity.character
    local input = entity.input
    local transform = entity.transform
    local physics = entity.physics
    local animator = entity.animator
    Sunshine:createStateSystem(entity, state, function()
        -- start check
        return 
    end, function()
        -- start
        physics.velocity = Vector3.new(0, component.power, 0)
        animator.action = 2504812300
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
    end)
end