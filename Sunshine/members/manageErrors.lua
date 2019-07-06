local errorFrame = game.ReplicatedStorage.Assets.frames.errorFrame
local ScriptContext = game:GetService("ScriptContext")

return function(Sunshine)
    ScriptContext.Error:Connect(function(_, _, errorScript)
        local success = pcall(function()
            errorScript:IsDescendantOf(game)
        end)
        if success then
            Sunshine.running = false
            errorFrame.Parent = Sunshine.gui
        end
    end)
end