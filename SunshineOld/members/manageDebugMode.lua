local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")

return function(Sunshine)
    RunService.RenderStepped:Connect(function()
        if Sunshine.running and Sunshine.debugMode then
            if UserInputService:IsKeyDown(Enum.KeyCode.RightShift) then
                if UserInputService:IsKeyDown(Enum.KeyCode.E) then
                    error("stop")
                end
            end
        end
    end)
end