if game:GetService("RunService") then
    local Sunshine = require(game:GetService("ReplicatedStorage"):WaitForChild("Sunshine"))

    for _, child in pairs(workspace:GetChildren()) do
        if child:IsA("Message") and child.Name == "SunshineSuiteWorkspace" then
            child:Destroy()
        end
    end
    Sunshine.workspace = Instance.new("Message")
    Sunshine.workspace.Name = "SunshineSuiteWorkspace"
    Sunshine.workspace.Parent = workspace
    Sunshine.gui = Instance.new("ScreenGui")
    Sunshine.gui.Name = "SunshineSuiteScreenGui"
    Sunshine.gui.IgnoreGuiInset = true -- why does this property need to exist it should always be true
    Sunshine.gui.ResetOnSpawn = false -- again should always be false
    Sunshine.gui.Parent = game:GetService("CoreGui") -- ANGERY
    Sunshine.plugin = plugin

    Sunshine:manage()
    Sunshine:addSystemFolder(script:WaitForChild("systems"))
    Sunshine:loadScene(require(script:WaitForChild("scene")))
end