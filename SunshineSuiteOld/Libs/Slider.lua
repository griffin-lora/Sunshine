local Roact = require(script.Parent.Parent.Roact)

local sliderWidth = 10

local Slider = Roact.PureComponent:extend("Slider")

-- props:
-- float value
-- float ticks
-- void setValue(float)
function Slider:render()
	local props = self.props
	return Roact.createElement("ImageButton", {
		Size = props.Size,
		Position = props.Position,
		LayoutOrder = props.LayoutOrder,
		BackgroundTransparency = 1.0,

		[Roact.Event.InputBegan] = function(rbx, input)
			if input.UserInputType == Enum.UserInputType.MouseButton1 then
				self.startPos = input.Position
				self:setState({
					pressed = true,
				})
				local mousePos = Vector2.new(
					input.Position.X,
					input.Position.Y
				)
				local value = math.clamp((mousePos.x - rbx.Bar.Container.AbsolutePosition.x) / rbx.Bar.Container.AbsoluteSize.x, 0, 1)
				if props.setValue then
					props.setValue(value)
				end
			end
		end,
		[Roact.Event.InputChanged] = function(rbx, input)
			if self.startPos and input.UserInputType == Enum.UserInputType.MouseMovement then
				local mousePos = Vector2.new(
					input.Position.X,
					input.Position.Y
				)
				local value = math.clamp((mousePos.x - rbx.Bar.Container.AbsolutePosition.x) / rbx.Bar.Container.AbsoluteSize.x, 0, 1)
				if props.setValue then
					props.setValue(value)
				end
			end
		end,
		[Roact.Event.InputEnded] = function(rbx, input)
			if input.UserInputType == Enum.UserInputType.MouseButton1 then
				self.startPos = nil
				self:setState({
					pressed = false,
				})
			end
		end,
	}, {
		Bar = Roact.createElement("Frame", {
			Position = UDim2.new(0.5, 0, 0.5, 0),
			AnchorPoint = Vector2.new(0.5, 0.5),
			Size = UDim2.new(1, -6, 0, 2),
			BackgroundColor3 = Color3.fromRGB(85, 85, 85),
			BorderSizePixel = 0,
		}, {
			Container = Roact.createElement("Frame", {
				BackgroundTransparency = 1,
				Position = UDim2.new(0,sliderWidth/2,0,0),
				Size = UDim2.new(1,-sliderWidth,1,0)
			}, {
				Slider = Roact.createElement("Frame", {
					AnchorPoint = Vector2.new(.5, .5),
					Position = UDim2.new(math.clamp(props.value or .5,0,1), 0, .5, 0),
					Size = UDim2.new(0, sliderWidth, 0, 20),
					BorderColor3 = self.state.pressed and Color3.fromRGB(0,0,0) or Color3.fromRGB(58, 58, 58),
					BackgroundColor3 = self.state.pressed and Color3.fromRGB(99,99,99) or Color3.fromRGB(66, 66, 66),
				}),
			}),
		})
	})
end

return Slider