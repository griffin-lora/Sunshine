local UserInputService = game:GetService("UserInputService")

return function(Sunshine, entity)
    local pause = entity.pause
    if pause then
        local lastP = false
        Sunshine:update(function()
            if UserInputService:IsKeyDown(Enum.KeyCode.P) and not lastP then
                entity.core.scene.active = not entity.core.scene.active
            end
            lastP = UserInputService:IsKeyDown(Enum.KeyCode.P)
        end, entity, true)
    end
end