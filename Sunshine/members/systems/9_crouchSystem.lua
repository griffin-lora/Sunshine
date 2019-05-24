local UserInputService = game:GetService("UserInputService")

return function(Sunshine, entity)
    local character = entity.character
    local physics = entity.physics
    if character and physics and character.controllable then
        Sunshine:update(function()
            if character.state == "crouch" then
                -- update
                if not (character.grounded and UserInputService:IsKeyDown(Enum.KeyCode.LeftShift)) then
                    -- end
                    character.state = nil
                end
            elseif character.grounded and UserInputService:IsKeyDown(Enum.KeyCode.LeftShift) then
                -- start
                character.state = "crouch"
            end
        end)
    end
end