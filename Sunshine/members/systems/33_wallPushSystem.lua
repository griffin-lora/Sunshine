local state = "wallPush"

return function(Sunshine, entity)
    local component = entity[state]
    local character = entity.character
    local transform = entity.transform
    local animator = entity.animator
    Sunshine:createStateSystem(entity, state, function()
        -- start check
        return not character.swimming and character.onWall and character.grounded and character.moving
    end, function()
        -- start
        animator.action = component.animation
    end, function()
        -- update
        transform.cFrame = CFrame.new(transform.cFrame.Position, transform.cFrame.Position - character.wallNormal)
    end, function()
        -- end check
        return not character.onWall or not character.moving or character.swimming
    end, function()
        -- end
        if character.state == state then
            animator.action = nil
        end
    end)
end