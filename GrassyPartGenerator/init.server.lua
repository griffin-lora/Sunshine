if not game:GetService("RunService"):IsEdit() then
    return
end

local ServerStorage = game:GetService("ServerStorage")
local CollectionService = game:GetService("CollectionService")
local Selection = game:GetService("Selection")

local surface
local bottom
local top

if ServerStorage:FindFirstChild("GrassyPartTextures") then
    local grassyPartTextures = ServerStorage.GrassyPartTextures
    if grassyPartTextures:FindFirstChild("Surface") and grassyPartTextures:FindFirstChild("Bottom") and
    grassyPartTextures:FindFirstChild("Top") then
        surface = grassyPartTextures.Surface
        bottom = grassyPartTextures.Bottom
        top = grassyPartTextures.Top
        print("All grassy part textures were found!")
    else
        warn("Some grassy part textures are missing. You must have the Surface, Bottom, and Top textures. Exiting.")
    end
else
    warn("No grassy part textures exist. Exiting.")
    return
end

local tree = {}
local allSides = workspace:FindFirstChild("AllSides") or Instance.new("Folder")
allSides.Name = "AllSides"
allSides:ClearAllChildren()
allSides.Parent = workspace

local function updateTree()
    for _, descendant in pairs(workspace:GetDescendants()) do
        if not tree[descendant] and CollectionService:HasTag(descendant, "GrassyPart") and
        not descendant:IsDescendantOf(allSides) then
            if descendant:FindFirstChild("Surface") then
                descendant.Surface:Destroy()
            end
            local sides = Instance.new("Folder")
            sides.Name = "Sides"
            sides.Parent = allSides
            local topPart = descendant:Clone()
            local function updateTopPart()
                topPart.Parent = nil
                topPart.CFrame = descendant.CFrame
                topPart.Size = descendant.Size
                topPart.Orientation = Vector3.new(descendant.Orientation.X, descendant.Orientation.Y, 180)
                topPart:Resize(Enum.NormalId.Top, top.StudsPerTileV - descendant.Size.Y)
                topPart.Parent = sides
            end
            updateTopPart()
            topPart:ClearAllChildren()
            topPart.Material = Enum.Material.Fabric
            topPart.Locked = true
            topPart.CanCollide = false
            topPart.Transparency = 1
            topPart.Parent = sides
            descendant:GetPropertyChangedSignal("CFrame"):Connect(updateTopPart)
            descendant:GetPropertyChangedSignal("Size"):Connect(updateTopPart)
            for id = 1, 4 do
                local face
                if id == 1 then
                    face = Enum.NormalId.Right
                elseif id == 2 then
                    face = Enum.NormalId.Left
                elseif id == 3 then
                    face = Enum.NormalId.Front
                else
                    face = Enum.NormalId.Back
                end
                local topClone = top:Clone()
                topClone.Face = face
                topClone.Parent = topPart
            end
            local surfaceClone = surface:Clone()
            surfaceClone.Face = Enum.NormalId.Top
            surfaceClone.Parent = descendant
        end
    end
end

local gui = plugin:CreateDockWidgetPluginGui("GPG", DockWidgetPluginGuiInfo.new(Enum.InitialDockState.Right,
false, false, 400, 500, 300, 80))
gui.Name = "GPG"
gui.Title = "Grassy Part Generator"

local guiFolder = Instance.new("Folder")
guiFolder.Parent = gui

local background = Instance.new("Frame")
background.Size = UDim2.new(1, 0, 1, 0)
background.BackgroundColor3 = Color3.new(0, 0, 0)
background.Parent = guiFolder

local makeButton = Instance.new("TextButton")
makeButton.AnchorPoint = Vector2.new(0.5, 0.5)
makeButton.Position = UDim2.new(0.5, 0, 0.5, 0)
makeButton.Size = UDim2.new(0, 200, 0, 50)
makeButton.Text = "Make Grassy Part"
makeButton.MouseButton1Click:Connect(function()
    for _, part in pairs(Selection:Get()) do
        if part:IsA("Part") then
            CollectionService:AddTag(part, "GrassyPart")
            updateTree()
            print("Made grassy part!")
        else
            warn("A non part was selected. Aborting.")
            break
        end
    end
end)
makeButton.Parent = background

workspace.DescendantAdded:Connect(function(descendant)
    if not tree[descendant] and CollectionService:HasTag(descendant, "GrassyPart") and
    not descendant:IsDescendantOf(allSides) then
        updateTree()
    end
end)

workspace.DescendantRemoving:Connect(function(descendant)
    if not tree[descendant] and CollectionService:HasTag(descendant, "GrassyPart") and
    not descendant:IsDescendantOf(allSides) then
        updateTree()
    end
end)

local toolbar = plugin:CreateToolbar("GPG")
local button = toolbar:CreateButton("Open GPG", "", "")
button.Click:Connect(function()
    gui.Enabled = not gui.Enabled
end)

updateTree()