if game:GetService("RunService"):IsEdit() then
    local Sunshine = require(script.Parent.Sunshine)
    local PluginNetworkClient = require(script.Parent.PluginNetworkClient)

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
    Sunshine.PluginNetworkClient = PluginNetworkClient
    PluginNetworkClient:init(plugin)

    Sunshine:manage()
    Sunshine:addSystemFolder(script:WaitForChild("systems"))
    Sunshine:loadScene(require(script:WaitForChild("scene")))
else
    wait(2)
    for _, child in pairs(workspace:GetChildren()) do
        if child:IsA("Message") and child.Name == "SunshineSuiteWorkspace" then
            child:Destroy()
        end
    end
end