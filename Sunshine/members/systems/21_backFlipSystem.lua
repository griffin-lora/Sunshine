local state = "backFlip"

return function(Sunshine, entity)
    local component = entity[state]
    local character = entity.character
    local input = entity.input
    local transform = entity.transform
    local physics = entity.physics
    local animator = entity.animator
    Sunshine:createStateSystem(entity, state, function()
        -- start check
        return character.state == "crouch" and physics.velocity.Magnitude < 13 and character.grounded and input.space
    end, function()
        -- start
        local horizontal = transform.cFrame.LookVector * component.backPower
        physics.velocity = Vector3.new(horizontal.X, component.power, horizontal.Z)
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
    end)
end