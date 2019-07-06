local UserInputService = game:GetService("UserInputService")

return function(Sunshine, entity, scene)
    local pause = entity.pause
    if pause then
        local lastP = false
        Sunshine:update(function()
            if UserInputService:IsKeyDown(Enum.KeyCode.P) and not lastP then
                scene.paused = not scene.paused
            end
            lastP = UserInputService:IsKeyDown(Enum.KeyCode.P)
        end, entity, true)
    end
end