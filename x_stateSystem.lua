local UserInputService = game:GetService("UserInputService")

return function(Sunshine, entity)
    local character = entity.character
    local physics = entity.physics
    if character and physics and character.controllable then
        Sunshine:update(function()
            if character.state == "state" then
                -- update
                if --[[end criteria]] then
                    -- end
                    character.state = nil
                end
            elseif --[[start criteria]] then
                -- start
                character.state = "state"
            end
        end)
    end
end