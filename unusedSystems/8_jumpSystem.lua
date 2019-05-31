local UserInputService = game:GetService("UserInputService")

return function(Sunshine, entity)
    local jump = entity.jump
    local character = entity.character
    local physics = entity.physics
    local animator = entity.animator
    if jump and character and physics and animator and character.controllable then
        local groundedRemember = 0
        Sunshine:update(function(step)
            groundedRemember = groundedRemember - step
            if character.grounded then
                groundedRemember = 2
            end
            if character.state == "jump" then
                -- update
                if character.grounded then
                    -- end
                    character.state = nil
                    animator.action = nil
                else
                    if physics.velocity.Y > 0 and not UserInputService:IsKeyDown(Enum.KeyCode.Space) then
                        physics.velocity = Vector3.new(physics.velocity.X, physics.velocity.Y * 0.8, physics.velocity.Z)
                    end
                end
            elseif groundedRemember > 0 and UserInputService:IsKeyDown(Enum.KeyCode.Space) then
                -- start
                groundedRemember = 0
                character.state = "jump"
                animator.action = 507765000
                physics.velocity = Vector3.new(physics.velocity.X, jump.power, physics.velocity.Z)
            end
        end)
    end
end