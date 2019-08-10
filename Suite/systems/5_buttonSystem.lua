return function(Sunshine, entity)
    local button = entity.button
    local frame = entity.frame
    local visible = entity.visible
    local uiTransform = entity.uiTransform
    local parent = entity.parent

    if button and uiTransform then
        local buttonInstance = Instance.new("TextButton")
        buttonInstance.Text = button.text
        buttonInstance.TextColor3 = button.textColor
        buttonInstance.TextScaled = true
        buttonInstance.TextTruncate = "AtEnd"
        buttonInstance.Font = button.font
        buttonInstance.BackgroundTransparency = 1
        Sunshine:addInstance(buttonInstance, entity)
        if parent then
            local parentEntity = Sunshine:getEntity(parent.parent, entity.core.scene)
            if parentEntity then
                local parentFrame = parentEntity.frame
                local parentLabel = parentEntity.label
                local parentWidget = parentEntity.widget
                if parentFrame then
                    buttonInstance.Parent = parentFrame.frame
                elseif parentLabel then
                    buttonInstance.Parent = parentLabel.label
                elseif parentWidget then
                    buttonInstance.Parent = parentWidget.widget
                end
            else
                buttonInstance.Parent = Sunshine.gui
            end
        else
            buttonInstance.Parent = Sunshine.gui
        end
        Sunshine:addConnection(buttonInstance.MouseButton1Click, function()
            button.activated = true
        end, entity)
        local endActivation = false
        local originalSize = button.size
        if frame then
            frame.frame.Size = button.size
        end
        Sunshine:update(function()
            buttonInstance.Position = uiTransform.position
            buttonInstance.Size = UDim2.new(originalSize.X.Scale * uiTransform.size.X, originalSize.X.Offset *
            uiTransform.size.X, originalSize.Y.Scale * uiTransform.size.Y, originalSize.Y.Offset * uiTransform.size.Y)
            if frame then
                frame.frame.Size = buttonInstance.Size
            end
            if visible then
                buttonInstance.Visible = visible.visible
            end
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