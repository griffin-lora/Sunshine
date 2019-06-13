local RunService = game:GetService("RunService")

return function(Sunshine, callback, entity)
    if not entity then
        warn("update is being used without entity specification.")
    end
    if not Sunshine.updateConnection then
        Sunshine.updateConnection = RunService.RenderStepped:Connect(function(...)
            if not Sunshine.paused then
                for _, callback in ipairs(Sunshine.updateCallbacks) do
                    if #Sunshine.updateCallbacks > 0 then
                        callback[1](...)
                    end
                end
            end
        end)
    end
    Sunshine.updateCallbacks[#Sunshine.updateCallbacks + 1] = {callback, entity}
end