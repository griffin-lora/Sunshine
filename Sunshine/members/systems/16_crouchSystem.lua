local state = "crouch"
local UserInputService = game:GetService("UserInputService")

return function(Sunshine, entity)
    local component = entity[state]
    local character = entity.character
    local input = entity.input
    local transform = entity.transform
    local physics = entity.physics
    local animator = entity.animator
    if component and character and input and transform and physics and animator then
        local lastState = character.state
        Sunshine:update(function()
            if character.controllable then
                if character.state == state then
                    -- update
                    character.walkSpeedFactor = component.walkSpeedFactor
                    if not input.shift or not character.grounded or (lastState == state and character.state ~= state) then
                        -- end
                        character.walkSpeedFactor = 1
                        character.state = nil
                    end
                elseif character.grounded and input.shift and UserInputService:GetFocusedTextBox() == nil or (lastState ~= state and character.state == state) and UserInputService:GetFocusedTextBox() == nil then
                    -- start
                    character.state = state
                    character.walkSpeedFactor = component.walkSpeedFactor
                end
            end
            lastState = character.state
        end)
    end
end