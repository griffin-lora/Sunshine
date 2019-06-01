local Roact = require(script.Parent.Parent.Roact)
local Constants = require(script.Parent.Constants)
local FitChildren = require(script.Parent.FitChildren)

local function Property(props)
	return Roact.createElement(FitChildren.Frame, {
		Size = UDim2.new(1, 0, 0, 24),
		LayoutOrder = props.LayoutOrder,
		BackgroundTransparency = 1.0,
	}, {
		PropertyLabel = Roact.createElement("Frame", {
			Size = UDim2.new(0, 180, 1, 0),
			BorderSizePixel = 1,
			BorderColor3 = Color3.fromRGB(34, 34, 34),
			BackgroundColor3 = Color3.fromRGB(46, 46, 46),
		}, {
			Contents = Roact.createElement("TextLabel", {
				Size = UDim2.new(1, -8, 1, 0),
				Position = UDim2.new(0, 8, 0, 0),
				Text = props.propertyName or "props.propertyName",
				Font = Enum.Font.SourceSans,
				TextSize = 14,
				TextColor3 = Constants.white,
				TextXAlignment = Enum.TextXAlignment.Left,
				BackgroundTransparency = 1.0,
			}),
		}),
		PropertyContainer = Roact.createElement("Frame", {
			Size = UDim2.new(1, -180, 1, 0),
			BorderSizePixel = 1,
			BorderColor3 = Color3.fromRGB(34, 34, 34),
			Position = UDim2.new(0, 180, 0, 0),
			BackgroundColor3 = Color3.fromRGB(46, 46, 46),
		}, {
			Contents = Roact.oneChild(props[Roact.Children])
		})
	})
end

return Property