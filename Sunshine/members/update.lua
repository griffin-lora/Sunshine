local RunService = game:GetService("RunService")
local step = 1/60

return function(Sunshine, callback, entity, ignoreActive)
    if not entity then
        error("update is being used without entity specification.")
    end
    if not Sunshine.updateConnection then
        Sunshine.updateConnection = RunService.RenderStepped:Connect(function(trueStep)
            if Sunshine.running and RunService:IsRunning() then
                for _, scene in pairs(Sunshine.scenes) do
                    if scene.active then
                        scene.tick = scene.tick + trueStep
                    end
                end
                for _, callbackInList in ipairs(Sunshine.updateCallbacks) do
                    local scene = Sunshine.entityScenes[callbackInList[2]]
                    if scene and ((entity.core.active and scene.active) or callbackInList[3]) then
                        callbackInList[1](step)
                    end
                end
            end
        end)
    end
    Sunshine.updateCallbacks[#Sunshine.updateCallbacks + 1] = {callback, entity, ignoreActive}
end