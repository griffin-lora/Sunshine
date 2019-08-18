local state = "wallJump"

return function(Sunshine, entity)
    local component = entity[state]
    local character = entity.character
    local input = entity.input
    local transform = entity.transform
    local physics = entity.physics
    local animator = entity.animator
    local speaker = entity.speaker
    local horizontal
    local lastSpace = false
    local jumpTick
    local walledTick
    Sunshine:createStateSystem(entity, state, function()
        -- start check
        return jumpTick and walledTick and entity.core.tick - walledTick < 0.1 and entity.core.tick - jumpTick < 0.1
    end, function()
        -- start
        jumpTick = nil
        walledTick = nil
        transform.cFrame = CFrame.new(transform.cFrame.Position, (transform.cFrame.Position) -
        transform.cFrame.LookVector)
        horizontal = transform.cFrame.LookVector * component.power
        physics.velocity = Vector3.new(horizontal.X, component.bouncePower, horizontal.Z)
        animator.action = component.animation
        if component.sound then
            speaker.id = component.sound
            speaker.playing = true
        end
    end, function()
        -- update
        physics.velocity = Vector3.new(horizontal.X, physics.velocity.Y, horizontal.Z)
    end, function()
        -- end check
        return character.grounded or character.swimming
    end, function()
        -- end
        if character.state == state then
            animator.action = nil
        end
    end, function()
        -- general update
        if character.state == "wallSlide" then
            walledTick = entity.core.tick
        end
        if input.space and not lastSpace then
            jumpTick = entity.core.tick
        end
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