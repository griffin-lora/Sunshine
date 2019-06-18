local state = "throw"

return function(Sunshine, entity)
    local component = entity[state]
    local character = entity.character
    local input = entity.input
    local transform = entity.transform
    local physics = entity.physics
    local animator = entity.animator
    local model = entity.model
    local lastE = false
    local head = {core = {}}
    local cFrame
    Sunshine:createStateSystem(entity, state, function()
        -- start check
        return not head.core.active and character.state ~= "groundPound" and character.state ~= "dive" and input.e and not lastE
    end, function()
        -- start
        if Sunshine:getEntityById(component.head) then
            cFrame = CFrame.new(transform.cFrame.Position + (transform.cFrame.LookVector.Unit * component.distance))
            local headClone = Sunshine:copyTable(Sunshine:getEntityById(component.head))
            headClone.core.active = true
            head = Sunshine:createEntity(headClone)
        end
        local velocityY
        if character.grounded then
            velocityY = physics.velocity.Y
        else
            velocityY = component.power
        end
        character.canLoseMagnitude = true
        physics.velocity = Vector3.new(physics.velocity.X * 0.1, velocityY, physics.velocity.Z * 0.1)
        if animator.action == component.animation then
            animator.action = nil
        else
            animator.action = component.animation
        end
    end, function()
        -- update
        head.core.active = true
        head.head.cFrame = cFrame
        character.canLoseMagnitude = false
        if not animator.action then
            animator.action = component.animation
        end
    end, function()
        -- end check
        return character.grounded
    end, function()
        -- end
    end, function()
        -- general update
        lastE = input.e
        -- hacky fix incoming
        if head.core.active then
            model.model.Head.Transparency = 1
            model.model.Head.face.Transparency = 1
        else
            model.model.Head.Transparency = 0
            model.model.Head.face.Transparency = 0
        end
    end)
end