-- TrafficConeGod

local state = "dive"

return function(Sunshine, entity)
    local component = entity[state]
    local character = entity.character
    local input = entity.input
    local transform = entity.transform
    local physics = entity.physics
    local animator = entity.animator
    local horizontal
    local lastE = false
    Sunshine:createStateSystem(entity, state, function()
        -- start check
        return not character.swimming and character.state == "groundPound" and not character.grounded and input.e and
        not lastE
    end, function()
        -- start
        physics.movable = true
        horizontal = transform.cFrame.LookVector * component.power
        physics.velocity = horizontal + Vector3.new(0, component.bouncePower, 0)
        animator.action = component.animation
    end, function(step)
        -- update
        horizontal = horizontal:Lerp(transform.cFrame.LookVector * component.power, step * 3)
        physics.velocity = Vector3.new(horizontal.X, physics.velocity.Y, horizontal.Z)
    end, function()
        -- end check
        return character.grounded or character.swimming
    end, function()
        -- end
        animator.action = component.endAnimation
    end, function()
        -- general update
        lastE = input.e
    end)
end