-- TrafficConeGod

local state = "dive"
local lastInput = false

return function(Sunshine, entity)
    local component = entity[state]
    local character = entity.character
    local input = entity.input
    local transform = entity.transform
    local physics = entity.physics
    local animator = entity.animator
    if component and character and input and transform and physics and animator and character.controllable then
        local lastState = character.state
        local horizontal
        Sunshine:update(function(step)
            if character.state == state then
                -- update
                horizontal = horizontal:Lerp(transform.cFrame.LookVector * component.power, step * 3)
                physics.velocity = Vector3.new(horizontal.X, physics.velocity.Y, horizontal.Z)
                if character.grounded or (lastState == state and character.state ~= state) then
                    -- end
                    character.state = nil
                    animator.action = 2794459258
                end
            elseif not character.grounded and input.e and not lastInput and character.controllable or character.controllable and (lastState ~= state and character.state == state) and not lastInput then
                -- start
                character.state = state
                horizontal = transform.cFrame.LookVector * component.power
                physics.velocity = horizontal + Vector3.new(0, 30, 0)
                animator.action = 1146922909
            end
			lastInput = input.e
        end)
    end
end