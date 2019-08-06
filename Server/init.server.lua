local Sunshine = require(game:GetService("ReplicatedStorage"):WaitForChild("Sunshine"))

Sunshine:addSystemFolder(script:WaitForChild("systems"))
Sunshine:loadScene(require(script:WaitForChild("scene")))