return function(script, plugin)

    local tweenEnums = {
        linear = Enum.EasingStyle.Linear,
        quadratic = Enum.EasingStyle.Quad,
        quartic = Enum.EasingStyle.Quart,
        quintic = Enum.EasingStyle.Quint,
        sinusoidal = Enum.EasingStyle.Sine,
        elastic = Enum.EasingStyle.Elastic,
        back = Enum.EasingStyle.Back,
        bounce = Enum.EasingStyle.Bounce,
        easeIn = Enum.EasingDirection.In,
        easeOut = Enum.EasingDirection.Out,
        easeInOut = Enum.EasingDirection.InOut
    }
    local tweenEnumsInverse = {
        [Enum.EasingStyle.Linear] = "linear",
        [Enum.EasingStyle.Quad] = "quadratic",
        [Enum.EasingStyle.Quart] = "quartic",
        [Enum.EasingStyle.Quint] = "quintic",
        [Enum.EasingStyle.Sine] = "sinusoidal",
        [Enum.EasingStyle.Elastic] = "elastic",
        [Enum.EasingStyle.Back] = "back",
        [Enum.EasingStyle.Bounce] = "bounce",
        [Enum.EasingDirection.In] = "easeIn",
        [Enum.EasingDirection.Out] = "easeOut",
        [Enum.EasingDirection.InOut] = "easeInOut",
    }
	
	local Selection = game:GetService("Selection")
	local ChangeHistoryService = game:GetService("ChangeHistoryService")
	local Libs = require(script.Parent.Libs)
	local Roact = require(script.Parent.Roact)
	local Components = require(script.Parent.Components)
	
	local Sunshine = {}
	
	Sunshine.Objects = {}
	
	function Sunshine:CopyTable(orig, copies)
	    copies = copies or {}
	    local orig_type = type(orig)
	    local copy
	    if orig_type == 'table' then
	        if copies[orig] then
	            copy = copies[orig]
	        else
	            copy = {}
	            for orig_key, orig_value in next, orig, nil do
	                copy[self:CopyTable(orig_key, copies)] = self:CopyTable(orig_value, copies)
	            end
	            copies[orig] = copy
	            setmetatable(copy, self:CopyTable(getmetatable(orig), copies))
	        end
	    else -- number, string, boolean, etc
	        copy = orig
	    end
	    return copy
	end
	
	function Sunshine:EncodeTable(table)
		
		local output = "{"
		
		for key, member in pairs(table) do
			
			local keyType = typeof(key)
				
			if keyType == "string" then
				
				output = output..key.."="
				
			elseif keyType ~= "number" then
				
				error("The key type "..keyType.." is not supported.")
				
			end
			
			local memberType = typeof(member)
			
			if memberType == "number" then
				
				output = output..member
				
			elseif memberType == "string" then
				
				output = output.."'"..member.."'"
				
			elseif memberType == "boolean" then
				
				if member then
					
					output = output.."true"
					
				else
					
					output = output.."false"
					
				end
				
			elseif memberType == "table" then
				
				output = output..self:EncodeTable(member)
				
			elseif memberType == "Instance" then
				
				output = output.."game."..member:GetFullName()
				
			elseif memberType == "CFrame" then
				
				local x, y, z, R00, R01, R02, R10, R11, R12, R20, R21, R22 = member:GetComponents()
				
				output = output.."CFrame.new("..x..","..y..","..z..","..R00..","..R01..","..R02..","..R10..","..R11..","..R12..","..R20..","..R21..","..R22..")"
				
			elseif memberType == "Vector3" then
				
				local x, y, z = member.X, member.Y, member.Z
				
				output = output.."Vector3.new("..x..","..y..","..z..")"
				
			elseif memberType == "UDim2" then
				
				local xScale, xOffset, yScale, yOffset = member.X.Scale, member.X.Offset, member.Y.Scale, member.Y.Offset
				
				output = output.."UDim2.new("..xScale..","..xOffset..","..yScale..","..yOffset..")"
				
			elseif memberType == "Color3" then
				
				local r, g, b = member.r, member.g, member.b
				
				output = output.."Color3.new("..r..","..g..","..b..")"
				
			elseif memberType == "Vector2" then
				
				local x, y = member.X, member.Y
				
				output = output.."Vector2.new("..x..","..y..")"
				
			elseif memberType == "TweenInfo" then
				
				local time, style, direction = member.Time, member.EasingStyle, member.EasingDirection
				
				output = output.."TweenInfo.new("..time..","..tostring(style)..","..tostring(direction)..")"
				
			elseif memberType == "function" then
				
				output = output.."function()end"
				
			else
				
				error("The member type "..memberType.." is not supported.")
				
			end
			
			output = output..","
			
		end
		
		output = output.."}"
		
		return output
		
    end
    
    function Sunshine:LoadPrefab(prefabInstance)
        Sunshine:LoadScene(prefabInstance, true)
    end
	
    function Sunshine:LoadScene(sceneInstance, prefab)
        self.Loading = true
        self.Prefab = prefab
        local scene
        Sunshine.Storage:ClearAllChildren()
        if prefab then
            scene = require(sceneInstance)
            local sceneClone = sceneInstance:Clone()
            sceneClone.Name = "LoadedPrefab"
            sceneClone.Parent = Sunshine.Storage
            scene = {entities = {scene}}
        else
            scene = require(sceneInstance)
            local sceneClone = sceneInstance:Clone()
            sceneClone.Name = "LoadedScene"
            sceneClone.Parent = Sunshine.Storage
        end
        self.SceneInstance = sceneInstance
		
		for index, member in pairs(self.Objects) do
			
			self.Objects[index] = nil
			
		end
		
		for index, child in pairs(workspace:GetChildren()) do
			
			if not child:IsA("Camera") and not child:IsA("Terrain") then
				
				child:Destroy()
				
			end
			
		end
		
		local world = scene.entities
		
		for index, object in pairs(world) do
		
			local fakeObject = self:CopyTable(object)
			
			if object.prefab and object.prefab.prefab then
				
				local prefab = require(object.prefab.prefab)
				
				for name, component in pairs(prefab) do
					
					if not object[name] then
						
						fakeObject[name] = self:CopyTable(component)
						
					end
					
				end
					
			end
			
			local model
			
			if fakeObject.model and fakeObject.model.model then
				
				model = fakeObject.model.model:Clone()
				
			else
				
				model = Instance.new("Model")
				
			end
			
			if object.core then
				
                model.Name = object.core.name
                local id = Instance.new("StringValue")
                id.Name = "EntityId"
                id.Value = object.core.id
                id.Parent = model
				
			end
			
			if object.transform then
				
				-- for index, descendant in pairs(model:GetDescendants()) do
					
				-- 	if descendant:IsA("BasePart") then
						
				-- 		descendant.CFrame = CFrame.new((descendant.CFrame.Position - object.transform.cFrame.Position) * object.transform.size + (object.transform.cFrame.Position * 2))
						
				-- 		descendant.Size = descendant.Size * object.transform.size
						
				-- 	end
					
				-- end
				
				if model.PrimaryPart then
                    
					model:SetPrimaryPartCFrame(object.transform.cFrame)
					
				end
				
			end
			
			model.Parent = workspace
		
			self.Objects[model] = object
			
		end
        self.Loading = false
		
	end
	
	function Sunshine:SaveScene()
        
        local sceneInstance = self.SceneInstance

        local scene
        
        if not self.Prefab then
            
            scene = {entities = {}}
            
            for index, member in pairs(self.Objects) do
                if index.Parent then
                    scene.entities[#scene.entities + 1] = member
                    
                end
                
            end
            
            ChangeHistoryService:SetWaypoint("F")
        else
            for _ , object in pairs(self.Objects) do
                scene = object
            end
            
        end
		
            
        sceneInstance.Source = "return "..self:EncodeTable(scene)
		local newSceneInstance = sceneInstance:Clone()
		
		newSceneInstance.Parent = sceneInstance.Parent
		
		sceneInstance:Destroy()
		
		self.SceneInstance = newSceneInstance
		
	end
	
	function Sunshine:LoadObject(objectInstance, frame)
		
        local object = self.Objects[objectInstance]
        
        if not object then
            frame:ClearAllChildren()
            return
        end
		
		local data = self:CopyTable(object)
		
		if data.prefab and data.prefab.prefab then
			
			local prefab = require(data.prefab.prefab)
			
			for name, component in pairs(prefab) do
				
				if not data[name] then
					
					data[name] = component
					
				end
				
			end
			
		end
		
		frame:ClearAllChildren()
		
		local tree = Roact.createElement("UIListLayout", {
			SortOrder = Enum.SortOrder.Name
		})
		
		Roact.mount(tree, frame, "UIListLayout")
		
		local addedComponentName
		
		local tree = Roact.createElement("Frame", {
			BackgroundTransparency = 1,
			Size = UDim2.new(1, 0, 1, 0)
		}, {
			
			A = Roact.createElement("UIListLayout", {
				SortOrder = Enum.SortOrder.Name,
				HorizontalAlignment = Enum.HorizontalAlignment.Center,
				Padding = UDim.new(0, 10)
			}),
			
			B = Roact.createElement(Libs.Textbox, {
				TextXAlignment = Enum.TextXAlignment.Center,
				value = "Component Name",
				setValue = function(rbx, value)
					
					if value ~= "core" then
						
						addedComponentName = value
						
					end
					
				end
			}),
			
			C = Roact.createElement(Libs.Button, {
				labelText = "Add Component",
				onClick = function()
					
					if Components[addedComponentName] and not object[addedComponentName] then
						
						object[addedComponentName] = {}
						
						local componentInterface = Components[addedComponentName]
						
						for name, propertyData in pairs(componentInterface) do
							
							object[addedComponentName][name] = propertyData.Default
							
						end
						
						self.Objects[objectInstance] = object
						self:SaveScene()
						self:LoadScene(self.SceneInstance, self.Prefab)
						
					end
					
				end
			}),
			
			D = Roact.createElement(Libs.Button, {
				labelText = "Remove Component",
				onClick = function()
					
					if Components[addedComponentName] and object[addedComponentName] then
						
						object[addedComponentName] = nil
						
						self.Objects[objectInstance] = object
						self:SaveScene()
						self:LoadScene(self.SceneInstance, self.Prefab)
						
					end
					
				end
			})
		})
		
		Roact.mount(tree, frame, "ZZZZZZZZ")
		
		for name, component in pairs(data) do
			
			local properties = {
				UIListLayout = Roact.createElement("UIListLayout", {
					SortOrder = Enum.SortOrder.Name
				})
			}
			
            local componentInterface = Components[name]
            if not componentInterface then
                error("component" .. name .. " doesn't exist.")
            end
			
			local componentName = name
			
			local function saveObject(value, name)
				
				if not object[componentName] then
					
					object[componentName] = {}
					for name, _ in pairs(componentInterface) do
						
						object[componentName][name] = object[componentName][name]
						
					end
					
				end
				object[componentName][name] = value
				self.Objects[objectInstance] = object
				self:SaveScene()
            end
            
			if componentName == "transform" then
                
				local primaryPart = objectInstance.PrimaryPart
				
				if primaryPart then
					
					primaryPart:GetPropertyChangedSignal("CFrame"):Connect(function()
						
						saveObject(primaryPart.CFrame, "cFrame")
						
					end)
					
					primaryPart:GetPropertyChangedSignal("Size"):Connect(function()
						
						local size = primaryPart.Size / object.Model.Model.PrimaryPart.Size
						
						saveObject(size, "size")
						
					end)
					
				end
				
			end
            
            
			for name, propertyData in pairs(componentInterface) do
				
				local propertyType = propertyData.Type
				
				local value
				
				if propertyType == "string" then
					
					value = Roact.createElement(Libs.Textbox, {
						Size = UDim2.new(1, 0, 0, 24),
						value = component[name],
						ClearTextOnFocus = false,
						onSubmit = function(rbx, value)
							
							rbx.Text = value
							saveObject(value, name)
							
						end
					})
					
				elseif propertyType == "number" then
					
					value = Roact.createElement(Libs.Textbox, {
						Size = UDim2.new(1, 0, 0, 24),
						value = component[name],
						ClearTextOnFocus = false,
						onSubmit = function(rbx, value)
							
							value = tonumber(value)
							
							if value then
								
								rbx.Text = value
								saveObject(value, name)
								
							else
								
								rbx.Text = component[name]
								
							end
							
						end
					})
					
				elseif propertyType == "boolean" then
					
					value = Roact.createElement(Libs.Checkbox, {
						LayoutOrder = 1,
						Size = UDim2.new(0, 24, 0, 24),
						value = component[name],
						setValue = function(value)
							
							saveObject(value, name)
							
						end
					})
					
				elseif propertyType == "Instance" then
					
					local connection
					
					local instanceName = "None"
					
					if component[name] then
						
						instanceName = component[name].Name
						
					end
					
					value = Roact.createElement("TextButton", {
						Size = UDim2.new(1, 0, 0, 24),
						Text = instanceName,
						TextColor3 = Color3.fromRGB(255, 255, 255),
						BackgroundTransparency = 1,
						[Roact.Event.MouseButton1Click] = function(rbx)
							
							if connection then
								connection:Disconnect()
							end
							
							connection = Selection.SelectionChanged:Connect(function()
								
								connection:Disconnect()
								
								local instance = game.Selection:Get()[1]
								
								rbx.Text = instance.Name
								
								game.Selection:Set({objectInstance})
								
								saveObject(instance, name)
								
								self:LoadScene(self.SceneInstance, self.Prefab)
								
							end)
							
						end
					})
					
				elseif propertyType == "Object" then
					
					local connection
					
					local instanceName = "None"
					
					if component[name] then
						
						for index, object in pairs(self.Objects) do
							
							if object.core and object.core.id == component[name] then
								
								instanceName = object.core.name
								
							end
							
						end
						
					end
					
					value = Roact.createElement("TextButton", {
						Size = UDim2.new(1, 0, 0, 24),
						Text = instanceName,
						TextColor3 = Color3.fromRGB(255, 255, 255),
						BackgroundTransparency = 1,
						[Roact.Event.MouseButton1Click] = function(rbx)
							
							if connection then
								connection:Disconnect()
							end
							
							connection = Selection.SelectionChanged:Connect(function()
								
								connection:Disconnect()
								
								local instance = game.Selection:Get()[1]
								
								rbx.Text = instance.Name
								
								game.Selection:Set({objectInstance})
								
								local selectedObject = self.Objects[instance]
								
								saveObject(selectedObject.core.id, name)
								
								self:LoadScene(self.SceneInstance, self.Prefab)
								
							end)
							
						end
					})
					
				elseif propertyType == "Vector3" then
					
					value = Roact.createElement(Libs.Textbox, {
						Size = UDim2.new(1, 0, 0, 24),
						value = component[name].X..", "..component[name].Y..", "..component[name].Z,
						ClearTextOnFocus = false,
						onSubmit = function(rbx, value)
							
							value = value:gsub(" ", "")
							
							local vectorData = {}
							
							for number in value:gmatch("[^%,]+") do
								
								vectorData[#vectorData + 1] = number
								
							end
							
							if #vectorData == 3 then
								
								local x, y, z = tonumber(vectorData[1]), tonumber(vectorData[2]), tonumber(vectorData[3])
								
								if x and y and z then
									
									rbx.Text = x..", "..y..", "..z
									value = Vector3.new(x, y, z)
									saveObject(value, name)
									self:LoadScene(self.SceneInstance, self.Prefab)
									
								else
									
									rbx.Text = component[name].X..", "..component[name].Y..", "..component[name].Z
									
								end
								
							else
								
								rbx.Text = component[name].X..", "..component[name].Y..", "..component[name].Z
								
							end
							
						end
					})
					
				elseif propertyType == "CFrame" then
					
					local rX, rY, rZ = component[name]:ToEulerAnglesXYZ()
					
					rX, rY, rZ = math.deg(rX), math.deg(rY), math.deg(rZ)
					
					value = Roact.createElement(Libs.Textbox, {
						Size = UDim2.new(1, 0, 0, 24),
						value = component[name].X..", "..component[name].Y..", "..component[name].Z..", "..rX..", "..rY..", "..rZ,
						ClearTextOnFocus = false,
						onSubmit = function(rbx, value)
							
							value = value:gsub(" ", "")
							
							local vectorData = {}
							
							for number in value:gmatch("[^%,]+") do
								
								vectorData[#vectorData + 1] = number
								
							end
							
							if #vectorData == 6 then
								
								local x, y, z, rX, rY, rZ = tonumber(vectorData[1]), tonumber(vectorData[2]), tonumber(vectorData[3]), tonumber(vectorData[4]), tonumber(vectorData[5]), tonumber(vectorData[6])
								
								if x and y and z and rX and rY and rZ then
									
									rbx.Text = x..", "..y..", "..z..", "..rX..", "..rY..", "..rZ
									value = CFrame.new(x, y, z) * CFrame.Angles(math.rad(rX), math.rad(rY), math.rad(rZ))
									saveObject(value, name)
									self:LoadScene(self.SceneInstance, self.Prefab)
									
								else
									
									rbx.Text = component[name].X..", "..component[name].Y..", "..component[name].Z
									
								end
								
							else
								
								rbx.Text = component[name].X..", "..component[name].Y..", "..component[name].Z
								
							end
							
						end
					})
					
				elseif propertyType == "Color3" then
					
					value = Roact.createElement(Libs.Textbox, {
						Size = UDim2.new(1, 0, 0, 24),
						value = math.floor(component[name].r * 255)..", "..math.floor(component[name].g * 255)..", "..math.floor(component[name].b * 255),
						ClearTextOnFocus = false,
						onSubmit = function(rbx, value)
							
							value = value:gsub(" ", "")
							
							local vectorData = {}
							
							for number in value:gmatch("[^%,]+") do
								
								vectorData[#vectorData + 1] = number
								
							end
							
							if #vectorData == 3 then
								
								local x, y, z = tonumber(vectorData[1]), tonumber(vectorData[2]), tonumber(vectorData[3])
								
								if (x and x < 256) and (y and y < 256) and (z and z < 256) then
									
									rbx.Text = x..", "..y..", "..z
									value = Color3.fromRGB(x, y, z)
									saveObject(value, name)
									
								else
									
									rbx.Text = math.floor(component[name].r * 255)..", "..math.floor(component[name].g * 255)..", "..math.floor(component[name].b * 255)
									
								end
								
							else
								
								rbx.Text = math.floor(component[name].r * 255)..", "..math.floor(component[name].g * 255)..", "..math.floor(component[name].b * 255)
								
							end
							
						end
					})
					
				elseif propertyType == "UDim2" then
					
					value = Roact.createElement(Libs.Textbox, {
						Size = UDim2.new(1, 0, 0, 24),
						value = component[name].X.Scale..", "..component[name].X.Offset..", "..component[name].Y.Scale..", "..component[name].Y.Offset,
						ClearTextOnFocus = false,
						onSubmit = function(rbx, value)
							
							value = value:gsub(" ", "")
							
							local vectorData = {}
							
							for number in value:gmatch("[^%,]+") do
								
								vectorData[#vectorData + 1] = number
								
							end
							
							if #vectorData == 4 then
								
								local xScale, xOffset, yScale, yOffset = tonumber(vectorData[1]), tonumber(vectorData[2]), tonumber(vectorData[3]), tonumber(vectorData[4])
								
								if xScale and xOffset and yScale and yOffset then
									
									rbx.Text = xScale..", "..xOffset..", "..yScale..", "..yOffset
									value = UDim2.new(xScale, xOffset, yScale, yOffset)
									saveObject(value, name)
									self:LoadScene(self.SceneInstance, self.Prefab)
									
								else
									
									rbx.Text = component[name].X.Scale..", "..component[name].X.Offset..", "..component[name].Y.Scale..", "..component[name].Y.Offset
									
								end
								
							else
								
								rbx.Text = component[name].X.Scale..", "..component[name].X.Offset..", "..component[name].Y.Scale..", "..component[name].Y.Offset
								
							end
							
						end
					})
					
				elseif propertyType == "Vector2" then
					
					value = Roact.createElement(Libs.Textbox, {
						Size = UDim2.new(1, 0, 0, 24),
						value = component[name].X..", "..component[name].Y,
						ClearTextOnFocus = false,
						onSubmit = function(rbx, value)
							
							value = value:gsub(" ", "")
							
							local vectorData = {}
							
							for number in value:gmatch("[^%,]+") do
								
								vectorData[#vectorData + 1] = number
								
							end
							
							if #vectorData == 2 then
								
								local x, y = tonumber(vectorData[1]), tonumber(vectorData[2])
								
								if x and y then
									
									rbx.Text = x..", "..y
									value = Vector2.new(x, y)
									saveObject(value, name)
									self:LoadScene(self.SceneInstance, self.Prefab)
									
								else
									
									rbx.Text = component[name].X..", "..component[name].Y
									
								end
								
							else
								
								rbx.Text = component[name].X..", "..component[name].Y
								
							end
							
						end
					})
					
					
				elseif propertyType == "TweenInfo" then
					
					value = Roact.createElement(Libs.Textbox, {
						Size = UDim2.new(1, 0, 0, 24),
						value = component[name].Time..", "..tweenEnumsInverse[component[name].EasingStyle]..", "..tweenEnumsInverse[component[name].EasingDirection],
						ClearTextOnFocus = false,
						onSubmit = function(rbx, value)
							
							value = value:gsub(" ", "")
							
							local vectorData = {}
							
							for number in value:gmatch("[^%,]+") do
								
								vectorData[#vectorData + 1] = number
								
							end
							
							if #vectorData == 3 then
								
								local x, y, z = tonumber(vectorData[1]), tweenEnums[vectorData[2]], tweenEnums[vectorData[3]]
								
								if x and y and z then
									
									rbx.Text = x..", "..vectorData[2]..", "..vectorData[3]
									value = TweenInfo.new(x, y, z)
									saveObject(value, name)
									self:LoadScene(self.SceneInstance, self.Prefab)
									
								else
									
									rbx.Text = component[name].Time..", "..tweenEnumsInverse[component[name].EasingStyle]..", "..tweenEnumsInverse[component[name].EasingDirection]
									
								end
								
							else
								
								rbx.Text = component[name].Time..", "..tweenEnumsInverse[component[name].EasingStyle]..", "..tweenEnumsInverse[component[name].EasingDirection]
								
							end
							
						end
					})
					
					
				end
				
				properties[name] = Roact.createElement(Libs.Property, {
					LayoutOrder = 1,
					propertyName = name
				}, {value})
				
			end
			
			local tree = Roact.createElement(Libs.Section, {
				titleText = name
			}, properties)
			
			Roact.mount(tree, frame, "Component")
			
		end
		
	end
	
	return Sunshine

end