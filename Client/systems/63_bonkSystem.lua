local state = "bonk"

return function(Sunshine, entity)
    local component = entity[state]
    local character = entity.character
    local transform = entity.transform
    local physics = entity.physics
    local animator = entity.animator
    local horizontal
    Sunshine:createStateSystem(entity, state, function()
        -- start check
        return (character.state == "dive" or character.state == "longJump") and not character.swimming and
        character.onWall and not character.grounded
    end, function()
        -- start
        horizontal = transform.cFrame.LookVector * component.power
        physics.velocity = horizontal
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
    end)
end