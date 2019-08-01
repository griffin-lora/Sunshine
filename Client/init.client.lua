local Sunshine = require(game:GetService("ReplicatedStorage"):WaitForChild("Sunshine"))
local Assets = game:GetService("ReplicatedStorage"):WaitForChild("Assets")

pcall(function()
	local starterGui = game:GetService('StarterGui')
	starterGui:SetCore("TopbarEnabled", false)
end)

Sunshine:addSystemFolder(script:WaitForChild("systems"))
Sunshine:loadScene(require(Assets.scenes.CrossroadsDay))