local SunshineSuite = {}

function SunshineSuite:init(plugin)
	
	plugin.Name = "SunshineSuite"
	
	local Selection = game:GetService("Selection")
	local HttpService = game:GetService("HttpService")
	local Sunshine = require(script.Parent.Sunshine)(script, plugin)
	local Libs = require(script.Parent.Libs.init)
	local Roact = require(script.Parent.Roact)
	
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
	objectCreatorGui.Title = "Object Creator"
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
				labelText = "Create Object",
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
	
	local nameLabel = sceneLoaderGui.SunshineSuite.Frame.A
	local frame = componentViewerGui.SunshineSuite.Frame
	
	local connection = Selection.SelectionChanged:Connect(function()
		
		local scene = Selection:Get()[1]
					
		if scene and scene:IsA("ModuleScript") then
			
			nameLabel.Text = scene.Name
			
		else
			
			nameLabel.Text = "Invalid Selection"
			
		end
		
		local objectInstance = Selection:Get()[1]
		
		if Sunshine.Objects[objectInstance] then
			
			Sunshine:LoadObject(objectInstance, frame)
			
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

end

return SunshineSuite