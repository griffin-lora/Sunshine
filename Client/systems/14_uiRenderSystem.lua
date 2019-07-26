-- TrafficConeGod

return function(Sunshine, entity)
    local frame = entity.frame
    local uiTransform = entity.uiTransform
    local transparency = entity.transparency
    local label = entity.label
    local visible = entity.visible
    if (frame or label) and uiTransform then
        if frame then
            frame.frame = frame.frame:Clone()
            Sunshine:addInstance(frame.frame, entity)
            frame.frame.Parent = Sunshine.gui
            local originalSize = frame.frame.Size
            Sunshine:update(function()
                frame.frame.Position = uiTransform.position
                frame.frame.Size = UDim2.new(originalSize.X.Scale * uiTransform.size.X, originalSize.X.Offset *
                uiTransform.size.X, originalSize.Y.Scale * uiTransform.size.Y, originalSize.Y.Offset *
                uiTransform.size.Y)
                frame.frame.Rotation = uiTransform.rotation
                frame.frame.ZIndex = uiTransform.zIndex
                frame.frame.AnchorPoint = uiTransform.anchorPoint
                if transparency then
                    frame.frame.BackgroundTransparency = transparency.transparency
                end
                if visible then
                    frame.frame.Visible = visible.visible
                end
            end, entity)
        end
        if label then
            local labelInstance = Instance.new("TextLabel")
            labelInstance.BackgroundTransparency = 1
            labelInstance.TextScaled = true
            Sunshine:addInstance(labelInstance, entity)
            labelInstance.Parent = Sunshine.gui
            local originalSize = label.size
            Sunshine:update(function()
                labelInstance.Position = uiTransform.position
                labelInstance.Font = Enum.Font.Highway
                labelInstance.Size = UDim2.new(originalSize.X.Scale * uiTransform.size.X, originalSize.X.Offset *
                uiTransform.size.X, originalSize.Y.Scale * uiTransform.size.Y, originalSize.Y.Offset *
                uiTransform.size.Y)
                labelInstance.Rotation = uiTransform.rotation
                labelInstance.ZIndex = uiTransform.zIndex
                labelInstance.AnchorPoint = uiTransform.anchorPoint
                labelInstance.Text = label.text
                labelInstance.TextColor3 = label.color
                if transparency then
                    labelInstance.TextTransparency = transparency.transparency
                end
                if visible then
                    labelInstance.Visible = visible.visible
                end
            end, entity)
        end
    end
end