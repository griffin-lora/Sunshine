local RunService = game:GetService("RunService")

return function(Sunshine)
    Sunshine.managing = true
    local function update(step)
        for _, scene in pairs(Sunshine.scenes) do
            for _, entity in pairs(scene.entities) do
                if scene.active and entity.core.active then
                    entity.core.tick = entity.core.tick + step
                end
                for _, callback in ipairs(entity.core.updateCallbacks) do
                    if (scene.active and entity.core.active) or callback[2] then
                        callback[1](1/60)
                    end
                end
            end
        end
    end
    if RunService:IsClient() then
        RunService.RenderStepped:Connect(update)
    end
end