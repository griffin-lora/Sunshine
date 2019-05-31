-- TrafficConeGod

local state = "jump"

return function(Sunshine, entity)
    local component = entity[state]
    local character = entity.character
    local input = entity.input
    local transform = entity.transform
    local physics = entity.physics
    local animator = entity.animator
    if component and character and input and transform and physics and animator and character.controllable then
        local lastState = character.state
        local groundedRemember = 0
        Sunshine:update(function(step)
            groundedRemember = groundedRemember - step
            if character.grounded then
                groundedRemember = 0.2
            end
            if character.state == state then
                -- update
                if physics.velocity.Y > 0 and not input.space then
                    physics.velocity = Vector3.new(physics.velocity.X, physics.velocity.Y * 0.8, physics.velocity.Z)
                end
                if character.grounded or (lastState == state and character.state ~= state) then
                    -- end
                    character.state = nil
                    animator.action = nil
                end
            elseif groundedRemember > 0 and input.space or (lastState ~= state and character.state == state) then
                -- start
                character.state = state
                groundedRemember = 0
                physics.velocity = Vector3.new(physics.velocity.X, component.power, physics.velocity.Z)
                animator.action = 507765000
            end
        end)
    end
end