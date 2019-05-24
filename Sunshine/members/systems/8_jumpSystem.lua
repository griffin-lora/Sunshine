local UserInputService = game:GetService("UserInputService")

return function(Sunshine, entity)
    local character = entity.character
    local physics = entity.physics
    local animator = entity.animator
    if character and physics and animator and character.controllable then
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
                end
            elseif groundedRemember > 0 and UserInputService:IsKeyDown(Enum.KeyCode.Space) then
                -- start
                groundedRemember = 0
                character.state = "jump"
                animator.action = 507765000
                physics.velocity = Vector3.new(physics.velocity.X, 50, physics.velocity.Z)
            end
        end)
    end
end