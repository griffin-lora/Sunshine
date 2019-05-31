local RunService = game:GetService("RunService")

return function(Sunshine, callback)
    if not Sunshine.updateConnection then
        Sunshine.updateConnection = RunService.RenderStepped:Connect(function(...)
            if not Sunshine.paused then
                for _, callback in ipairs(Sunshine.updateCallbacks) do
                    if #Sunshine.updateCallbacks > 0 then
                        callback(...)
                    end
                end
            end
        end)
    end
    Sunshine.updateCallbacks[#Sunshine.updateCallbacks + 1] = callback
end