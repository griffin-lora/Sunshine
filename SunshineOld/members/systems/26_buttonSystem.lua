return function(Sunshine, entity)
    local button = entity.button
    local uiTransform = entity.uiTransform
    if button and uiTransform then
        local buttonInstance = Instance.new("TextButton")
        buttonInstance.Text = ""
        buttonInstance.BackgroundTransparency = 1
        Sunshine:addInstance(buttonInstance, entity)
        buttonInstance.Parent = Sunshine.gui
        Sunshine:addConnection(buttonInstance.MouseButton1Click, function()
            button.activated = true
        end, entity)
        local endActivation = false
        local originalSize = button.size
        Sunshine:update(function()
            buttonInstance.Position = uiTransform.position
            buttonInstance.Size = UDim2.new(originalSize.X.Scale * uiTransform.size.X, originalSize.X.Offset *
            uiTransform.size.X, originalSize.Y.Scale * uiTransform.size.Y, originalSize.Y.Offset * uiTransform.size.Y)
            buttonInstance.Rotation = uiTransform.rotation
            buttonInstance.ZIndex = uiTransform.zIndex
            buttonInstance.AnchorPoint = uiTransform.anchorPoint
            if button.activated then
                if endActivation then
                    button.activated = false
                    endActivation = false
                else
                    endActivation = true
                end
            end
        end, entity)
    end
end