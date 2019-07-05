local errorFrame = game.ReplicatedStorage.Assets.frames.errorFrame
local ScriptContext = game:GetService("ScriptContext")

return function(Sunshine)
    ScriptContext.Error:Connect(function()
        Sunshine.running = false
        errorFrame.Parent = Sunshine.gui
    end)
end