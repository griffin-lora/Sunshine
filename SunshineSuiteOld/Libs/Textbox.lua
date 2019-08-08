local Roact = require(script.Parent.Parent.Roact)
local Constants = require(script.Parent.Constants)

local Textbox = Roact.Component:extend("Textbox")

function Textbox:render()
	local props = self.props
	local value = props.value
	local setValue = props.setValue
	local focusLost = props.focusLost
	local onSubmit = props.onSubmit
	local focused = props.focused

	return Roact.createElement("Frame", {
		Size = props.Size or UDim2.new(0, 300, 0, 20),
		Position = props.Position,
		LayoutOrder = props.LayoutOrder,
		BackgroundColor3 = focused and Color3.fromRGB(34, 34, 34) or Color3.fromRGB(46, 46, 46),
		BorderColor3 = Color3.fromRGB(34, 34, 34),
		BorderSizePixel = focused and 1 or 0,
	}, {
		TextInput = Roact.createElement("TextBox", {
			Font = Enum.Font.SourceSans,
			TextSize = 15,
			BackgroundTransparency = 1.0,
			TextXAlignment = props.TextXAlignment or Enum.TextXAlignment.Left,
			TextYAlignment = props.TextYAlignment or Enum.TextYAlignment.Center,
			Size = UDim2.new(1, -4, 1, -2),
			Position = UDim2.new(0, 4, 0, 0),
			ClipsDescendants = true,
			ClearTextOnFocus = props.ClearTextOnFocus,
			Text = tostring(value),
			TextColor3 = Color3.new(1,1,1),
			
			[Roact.Event.Focused] = props.onFocused,

			[Roact.Event.FocusLost] = function(rbx, enterPressed)
				if enterPressed then
					if onSubmit then
						onSubmit(rbx, rbx.Text)
					end
				else
					if focusLost then
						focusLost(rbx, rbx.Text)
					end
				end
			end,

			[Roact.Change.Text] = function(rbx)
				if self.debounce then
					return
				end
				self.debounce = true
				local oldText = self.props.value
				local newText = rbx.Text
				if setValue and newText ~= oldText then
					setValue(rbx, newText)
				end
				self.debounce = false
			end,
		})
	})
end

return Textbox