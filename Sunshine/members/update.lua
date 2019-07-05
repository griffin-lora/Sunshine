local RunService = game:GetService("RunService")
local step = 1/60

return function(Sunshine, callback, entity)
    if not entity then
        error("update is being used without entity specification.")
    end
    if not Sunshine.updateConnection then
        Sunshine.updateConnection = RunService.RenderStepped:Connect(function()
            if not Sunshine.paused and Sunshine.running and RunService:IsRunning() then
                for _, callbackInList in ipairs(Sunshine.updateCallbacks) do
                    if #Sunshine.updateCallbacks > 0 then
                        callbackInList[1](step)
                    end
                end
            end
        end)
    end
    Sunshine.updateCallbacks[#Sunshine.updateCallbacks + 1] = {callback, entity}
end