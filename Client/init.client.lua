local Sunshine = require(game:GetService("ReplicatedStorage"):WaitForChild("Sunshine"))
local Assets = game:GetService("ReplicatedStorage"):WaitForChild("Assets")

pcall(function()
	local starterGui = game:GetService('StarterGui')
	starterGui:SetCore("TopbarEnabled", false)
end)

Sunshine:addSystemFolder(script:WaitForChild("systems"))
Sunshine:loadScene(require(Assets:WaitForChild("scenes").CrossroadsDay))
Sunshine:loadScene(require(Assets.scenes.uiScene), 2)
Sunshine:loadScene(require(Assets.scenes.musicScene), 3)