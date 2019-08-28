local state = "wallSlide"

local CFRAME_NEW = CFrame.new
local VECTOR3_NEW = Vector3.new

return function(Sunshine, entity)
    local component = entity[state]
    local character = entity.character
    local transform = entity.transform
    local physics = entity.physics
    local animator = entity.animator
    local lastWall
    Sunshine:createStateSystem(entity, state, function()
        -- start check
        return character.state ~= "longJump" and character.state ~= "dive"and not character.swimming and
        character.onWall and character.wall ~= lastWall and not character.grounded and
        VECTOR3_NEW(physics.velocity.X, 0, physics.velocity.Z).Magnitude > 1 and character.state ~= "bonk"
    end, function()
        -- start
        lastWall = character.wall
        animator.action = component.animation
    end, function(step)
        -- update
        physics.velocity = VECTOR3_NEW(0, physics.velocity.Y, 0):Lerp(VECTOR3_NEW(0, component.speed, 0), step * 5)
        transform.cFrame = CFRAME_NEW(transform.cFrame.Position, transform.cFrame.Position - character.wallNormal)
    end, function()
        -- end check
        return character.grounded or not character.onWall or character.swimming
    end, function()
        -- end
        if character.state == state then
            animator.action = nil
        end
    end, function()
        -- general update
        if character.grounded then
            lastWall = nil
        end
    end)
end