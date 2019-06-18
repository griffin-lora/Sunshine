local state = "wallPush"

return function(Sunshine, entity)
    local component = entity[state]
    local character = entity.character
    local input = entity.input
    local transform = entity.transform
    local physics = entity.physics
    local animator = entity.animator
    Sunshine:createStateSystem(entity, state, function()
        -- start check
        return character.onWall and character.grounded and character.moving
    end, function()
        -- start
        animator.action = component.animation
    end, function()
        -- update
        transform.cFrame = CFrame.new(transform.cFrame.Position, transform.cFrame.Position - character.wallNormal)
    end, function()
        -- end check
        return not character.onWall or not character.moving
    end, function()
        -- end
        if character.state == state then
            animator.action = nil
        end
    end)
end