if not game:GetService("ReplicatedStorage"):FindFirstChild("Sunshine") then
    error("Sunshine not found. Aborting.")
end

local Sunshine = require(game:GetService("ReplicatedStorage").Sunshine)

Sunshine.workspace = Instance.new("Message")
Sunshine.workspace.Parent = workspace
Sunshine.plugin = plugin
Sunshine:manage()
Sunshine:addSystemFolder(script:WaitForChild("systems"))
Sunshine:loadScene(require(script:WaitForChild("scene")))