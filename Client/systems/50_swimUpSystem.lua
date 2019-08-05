local state = "swimUp"
local oldGravity = workspace.Gravity

return function(Sunshine, entity)
    local component = entity[state]
    local character = entity.character
    local input = entity.input
    local physics = entity.physics
    local animator = entity.animator
    local speaker = entity.speaker
    local lastSpace = false
    Sunshine:createStateSystem(entity, state, function()
        -- start check
        return character.swimming and input.space and not lastSpace
    end, function()
        -- start
        physics.velocity = Vector3.new(physics.velocity.X, component.power, physics.velocity.Z)
        animator.action = nil
        if component.sound then
            speaker.id = component.sound
            speaker.playing = true
        end
    end, function()
        -- update
        if animator.action ~= component.animation then
            animator.action = component.animation
        end
    end, function()
        -- end check
        return true
    end, function()
        -- end
    end, function()
        -- general update
        local gravity = false
        if character.swimming or character.state == "wallSlide" then
            gravity = true
        end
        lastSpace = input.space
        workspace.Gravity = gravity and 70 or oldGravity
    end)
end