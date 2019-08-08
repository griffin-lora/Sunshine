if not game:GetService("RunService"):IsEdit() then
    return
end

plugin.Name = "SunshineSuite"

local Selection = game:GetService("Selection")
local HttpService = game:GetService("HttpService")
local ServerStorage = game:GetService("ServerStorage")
local Sunshine = require(script.Parent.Sunshine)(script, plugin)
local Libs = require(script.Parent.Libs)
local Roact = require(script.Parent.Roact)

wait(3)

if ServerStorage:FindFirstChild("SunshineSuiteStorage") then
    Sunshine.Storage = ServerStorage.SunshineSuiteStorage
else
    local storage = Instance.new("Folder")
    storage.Name = "SunshineSuiteStorage"
    Sunshine.Storage = storage
    storage.Parent = ServerStorage
end

local enabled = false

local pluginGuis = {}

local sceneLoaderGui = plugin:CreateDockWidgetPluginGui("SceneLoader", DockWidgetPluginGuiInfo.new(Enum.InitialDockState.Right, false, false, 400, 500, 300, 80))
sceneLoaderGui.Name = "SceneLoader"
sceneLoaderGui.Title = "Scene Loader"
table.insert(pluginGuis, sceneLoaderGui)

local tree = Roact.createElement("Folder", {}, {
    Frame = Roact.createElement("Frame", {
        Size = UDim2.new(1, 0, 1, 0),
        BackgroundColor3 = Color3.fromRGB(46, 46, 46),
        BorderSizePixel = 0
    }, {
        UIListLayout = Roact.createElement("UIListLayout", {
            SortOrder = Enum.SortOrder.Name,
            HorizontalAlignment = Enum.HorizontalAlignment.Center,
            Padding = UDim.new(0, 20)
        }),
        A = Roact.createElement(Libs.Label, {
            labelText = "",
            textSize = 30,
            textColor = Color3.fromRGB(255, 255, 255)
        }),
        B = Roact.createElement(Libs.Button, {
            labelText = "Load Scene",
            onClick = function()
                
                local scene = Selection:Get()[1]
                
                if scene and scene:IsA("ModuleScript") then
                    
                    Sunshine:LoadScene(scene)
                    
                end
                
            end
        })
    })
})

Roact.mount(tree, sceneLoaderGui, "SunshineSuite")

local componentViewerGui = plugin:CreateDockWidgetPluginGui("ComponentViewer", DockWidgetPluginGuiInfo.new(Enum.InitialDockState.Left, false, false, 400, 500, 300, 80))
componentViewerGui.Name = "ComponentViewer"
componentViewerGui.Title = "Component Viewer"
table.insert(pluginGuis, componentViewerGui)

local tree = Roact.createElement("Folder", {}, {
    Frame = Roact.createElement("ScrollingFrame", {
        Size = UDim2.new(1, 0, 1, 0),
        BackgroundColor3 = Color3.fromRGB(46, 46, 46),
        BorderSizePixel = 0,
        BottomImage = "rbxassetid://2144428525",
        TopImage = "rbxassetid://2144428525",
        MidImage = "rbxassetid://2144428525",
        CanvasSize = UDim2.new(0, 0, 0, 5000),
    })
})

Roact.mount(tree, componentViewerGui, "SunshineSuite")

local objectCreatorGui = plugin:CreateDockWidgetPluginGui("ObjectCreator", DockWidgetPluginGuiInfo.new(Enum.InitialDockState.Left, false, false, 400, 500, 300, 80))
objectCreatorGui.Name = "ObjectCreator"
objectCreatorGui.Title = "Entity Creator"
table.insert(pluginGuis, objectCreatorGui)

local tree = Roact.createElement("Folder", {}, {
    Frame = Roact.createElement("Frame", {
        Size = UDim2.new(1, 0, 1, 0),
        BackgroundColor3 = Color3.fromRGB(46, 46, 46),
        BorderSizePixel = 0
    }, {
        UIListLayout = Roact.createElement("UIListLayout", {
            SortOrder = Enum.SortOrder.Name,
            HorizontalAlignment = Enum.HorizontalAlignment.Center,
            Padding = UDim.new(0, 20)
        }),
        B = Roact.createElement(Libs.Button, {
            labelText = "Create Entity",
            onClick = function()
                
                if Sunshine.SceneInstance then
                    
                    local object = {core = {id = HttpService:GenerateGUID(), name = "Object"}, model = {model = nil}, transform = {cFrame = CFrame.new(), size = Vector3.new(1, 1, 1)}}
                    
                    local model = Instance.new("Model")
                    
                    model.Parent = workspace
                    
                    Sunshine.Objects[model] = object
                    
                    Sunshine:SaveScene()
                    
                    Sunshine:LoadScene(Sunshine.SceneInstance)
                    
                end
                
            end
        })
    })
})

Roact.mount(tree, objectCreatorGui, "SunshineSuite")
local prefabEditorGui = plugin:CreateDockWidgetPluginGui("PrefabEditor", DockWidgetPluginGuiInfo.new(Enum.InitialDockState.Right, false, false, 400, 500, 300, 80))
prefabEditorGui.Name = "PrefabEditor"
prefabEditorGui.Title = "Prefab Editor"
table.insert(pluginGuis, prefabEditorGui)

local tree = Roact.createElement("Folder", {}, {
    Frame = Roact.createElement("Frame", {
        Size = UDim2.new(1, 0, 1, 0),
        BackgroundColor3 = Color3.fromRGB(46, 46, 46),
        BorderSizePixel = 0
    }, {
        UIListLayout = Roact.createElement("UIListLayout", {
            SortOrder = Enum.SortOrder.Name,
            HorizontalAlignment = Enum.HorizontalAlignment.Center,
            Padding = UDim.new(0, 20)
        }),
        A = Roact.createElement(Libs.Label, {
            labelText = "",
            textSize = 30,
            textColor = Color3.fromRGB(255, 255, 255)
        }),
        B = Roact.createElement(Libs.Button, {
            labelText = "Edit Prefab",
            onClick = function()
                
                local prefab = Selection:Get()[1]
                
                if prefab and prefab:IsA("ModuleScript") then
                    
                    Sunshine:LoadPrefab(prefab)
                    
                end
                
            end
        })
    })
})

Roact.mount(tree, prefabEditorGui, "SunshineSuite")

local prefabNameLabel = prefabEditorGui.SunshineSuite.Frame.A
local nameLabel = sceneLoaderGui.SunshineSuite.Frame.A
local frame = componentViewerGui.SunshineSuite.Frame

local connection = Selection.SelectionChanged:Connect(function()
    
    local scene = Selection:Get()[1]
                
    if scene and scene:IsA("ModuleScript") then
        
        nameLabel.Text = scene.Name
        prefabNameLabel.Text = scene.Name
        
    else
        
        nameLabel.Text = "Invalid Selection"
        prefabNameLabel.Text = "Invalid Selection"
        
    end
    
    local objectInstance = Selection:Get()[1]
    
    if Sunshine.Objects[objectInstance] then
        
        Sunshine:LoadObject(objectInstance, frame)
        
    else
        
        Sunshine:LoadObject(nil, frame)
        
    end
    
end)

workspace.ChildAdded:Connect(function(child)
    if not Sunshine.Loading and not Sunshine.Prefab and child:FindFirstChild("EntityId") then
        local entityId = child.EntityId
        for instance, entity in pairs(Sunshine.Objects) do
            if instance.EntityId.Value == entityId.Value then
                local entity = Sunshine:CopyTable(entity)
                entity.core.id = HttpService:GenerateGUID()
                Sunshine.Objects[child] = entity
                Sunshine:SaveScene()
                Sunshine:LoadScene(Sunshine.SceneInstance, Sunshine.Prefab)
                break
            end
        end
    end
end)

plugin.Deactivation:Connect(function()
    
    connection:Disconnect()
    
end)

local toolbar = plugin:CreateToolbar("Sunshine")
local button = toolbar:CreateButton("Open Sunshine", "", "")

button.Click:Connect(function()
    
    enabled = not enabled
    
    for index, pluginGui in pairs(pluginGuis) do
                
        pluginGui.Enabled = enabled
        
    end
    
end)

if Sunshine.Storage:FindFirstChild("LoadedScene") then
    Sunshine:LoadScene(Sunshine.Storage.LoadedScene)
elseif Sunshine.Storage:FindFirstChild("LoadedPrefab") then
    Sunshine:LoadPrefab(Sunshine.Storage.LoadedPrefab)
end