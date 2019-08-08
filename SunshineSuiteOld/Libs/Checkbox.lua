local Roact = require(script.Parent.Parent.Roact)

local enabledImage = "rbxassetid://2144125664"

local function Checkbox(props)
	-- nil == indeterminate
	local value = props.value
	local setValue = props.setValue

	return Roact.createElement("ImageButton", {
		LayoutOrder = props.LayoutOrder,
		Size = props.Size or UDim2.new(0, 20, 0, 20),
		BackgroundTransparency = 1.0,

		[Roact.Event.MouseButton1Click] = function(rbx)
			-- nil -> true, false -> true, true -> false
			if setValue then
				setValue(value ~= true)
				value = value ~= true
				if value then
					rbx.Frame.CheckImage.Image = enabledImage
				else
					rbx.Frame.CheckImage.Image = ""
				end
			end
		end,
	}, {
		Frame = Roact.createElement("Frame", {
			Size = UDim2.new(0, 15, 0, 15),
			AnchorPoint = Vector2.new(0.5, 0.5),
			Position = UDim2.new(0.5, 0, 0.5, 0),
			BackgroundColor3 = Color3.fromRGB(37, 37, 37),
			BorderSizePixel = 0,
		}, {
			CheckImage = Roact.createElement("ImageLabel", {
				Size = UDim2.new(0, 15, 0, 15),
				Image = value and enabledImage or "",
				ImageColor3 = Color3.fromRGB(52, 174, 244),
				BackgroundTransparency = value == nil and 0.0 or 1.0,
				BackgroundColor3 = Color3.fromRGB(192, 192, 255),
				BorderSizePixel = 0,
				AnchorPoint = Vector2.new(0.5, 0.5),
				Position = UDim2.new(0.5, 0, 0.5, 0),
			})
		})
	})
end

return Checkbox