local state = "wallJump"

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
        return character.state == "wallSlide" and input.space and not lastSpace
    end, function()
        -- start
        transform.cFrame = CFrame.new(transform.cFrame.Position, (transform.cFrame.Position) - transform.cFrame.LookVector)
        local horizontal = transform.cFrame.LookVector * component.power
        physics.velocity = Vector3.new(horizontal.X, component.bouncePower, horizontal.Z)
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
        lastSpace = input.space
    end)
end