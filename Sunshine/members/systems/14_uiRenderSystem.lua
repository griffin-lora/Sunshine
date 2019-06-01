-- TrafficConeGod

local Players = game:GetService("Players")
local player = Players.LocalPlayer
local playerGui = player.PlayerGui

local gui = Instance.new("ScreenGui") -- because roblox is a meanie engine
gui.IgnoreGuiInset = true -- why does this property need to exist it should always be true
gui.ResetOnSpawn = false -- again should always be false
gui.Parent = playerGui -- ANGERY

return function(Sunshine, entity)
    local frame = entity.frame
    local uiTransform = entity.uiTransform
    if frame and uiTransform then
        frame.frame = frame.frame:Clone()
        Sunshine:addInstance(frame.frame)
        frame.frame.Parent = gui
        local originalSize = frame.frame.Size
        Sunshine:update(function()
            frame.frame.Position = uiTransform.position
            frame.frame.Size = UDim2.new(originalSize.X.Scale * uiTransform.size.X, originalSize.X.Offset * uiTransform.size.X, originalSize.Y.Scale * uiTransform.size.Y, originalSize.Y.Offset * uiTransform.size.Y)
            frame.frame.Rotation = uiTransform.rotation
            frame.frame.ZIndex = uiTransform.zIndex
        end)
    end
end