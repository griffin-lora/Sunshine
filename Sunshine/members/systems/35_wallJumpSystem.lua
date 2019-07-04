local state = "wallJump"

return function(Sunshine, entity)
    local component = entity[state]
    local character = entity.character
    local input = entity.input
    local transform = entity.transform
    local physics = entity.physics
    local animator = entity.animator
    local horizontal
    local lastSpace = false
    Sunshine:createStateSystem(entity, state, function()
        -- start check
        return character.state == "wallSlide" and input.space and not lastSpace
    end, function()
        -- start
        transform.cFrame = CFrame.new(transform.cFrame.Position, (transform.cFrame.Position) -
        transform.cFrame.LookVector)
        horizontal = transform.cFrame.LookVector * component.power
        physics.velocity = Vector3.new(horizontal.X, component.bouncePower, horizontal.Z)
        animator.action = component.animation
    end, function()
        -- update
        physics.velocity = Vector3.new(horizontal.X, physics.velocity.Y, horizontal.Z)
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

--[[
    function()
        -- start
        physics.movable = true
        horizontal = transform.cFrame.LookVector * component.power
        physics.velocity = horizontal + Vector3.new(0, 30, 0)
        animator.action = component.animation
    end, function(step)
        -- update
        horizontal = horizontal:Lerp(transform.cFrame.LookVector * component.power, step * 3)
        physics.velocity = Vector3.new(horizontal.X, physics.velocity.Y, horizontal.Z)
    end
]]