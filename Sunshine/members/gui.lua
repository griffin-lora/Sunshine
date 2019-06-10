local Players = game:GetService("Players")
local player = Players.LocalPlayer
local playerGui = player.PlayerGui

local gui = Instance.new("ScreenGui") -- because roblox is a meanie engine
gui.IgnoreGuiInset = true -- why does this property need to exist it should always be true
gui.ResetOnSpawn = false -- again should always be false
gui.Parent = playerGui -- ANGERY

return gui