local state = "throw"

return function(Sunshine, entity)
    local component = entity[state]
    local character = entity.character
    local input = entity.input
    local transform = entity.transform
    local physics = entity.physics
    local animator = entity.animator
    local lastE = false
    local head
    Sunshine:createStateSystem(entity, state, function()
        -- start check
        return character.state ~= "groundPound" and character.state ~= "dive" and input.e and not lastE
    end, function()
        -- start
        if not head and Sunshine:getEntityById(component.head) then
            local headClone = Sunshine:copyTable(Sunshine:getEntityById(component.head))
            headClone.core.active = true
            headClone.head.cFrame = CFrame.new(transform.cFrame.Position + (transform.cFrame.LookVector.Unit * 10))
            head = Sunshine:createEntity(headClone)
        end
        local velocityY
        if character.grounded then
            velocityY = physics.velocity.Y
        else
            velocityY = component.power
        end
        physics.velocity = Vector3.new(physics.velocity.X * 0.1, velocityY, physics.velocity.Z * 0.1)
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