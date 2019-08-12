-- TrafficConeGod

return function(Sunshine, entity)
    local frame = entity.frame
    local uiTransform = entity.uiTransform
    local transparency = entity.transparency
    local label = entity.label
    local parent = entity.parent
    local visible = entity.visible
    if (frame or label) and uiTransform then
        if frame then
            frame.frame = frame.frame:Clone()
            if uiTransform.zIndex ~= nil then
                for _,ui in pairs(frame.frame:GetDescendants()) do
                    if ui:IsA("GuiBase") then
                        ui.ZIndex = uiTransform.zIndex
                    end
                end
            end
            Sunshine:addInstance(frame.frame, entity)
            if parent then
                local parentEntity = Sunshine:getEntity(parent.parent, entity.core.scene)
                if parentEntity then
                    local parentFrame = parentEntity.frame
                    local parentLabel = parentEntity.label
                    local parentWidget = parentEntity.widget
                    local parentScroll = parentEntity.scrollingFrame
                    if parentFrame then
                        frame.frame.Parent = parentFrame.frame
                    elseif parentLabel then
                        frame.frame.Parent = parentLabel.label
                    elseif parentWidget then
                        frame.frame.Parent = parentWidget.widget
                    elseif parentScroll then
                        frame.frame.Parent = parentScroll.frame
                    end
                else
                    frame.frame.Parent = Sunshine.gui
                end
            else
                frame.frame.Parent = Sunshine.gui
            end
            local originalSize = frame.frame.Size
            Sunshine:update(function()
                frame.frame.Position = uiTransform.position
                frame.frame.Size = UDim2.new(originalSize.X.Scale * uiTransform.size.X, originalSize.X.Offset *
                uiTransform.size.X, originalSize.Y.Scale * uiTransform.size.Y, originalSize.Y.Offset *
                uiTransform.size.Y)
                frame.frame.Rotation = uiTransform.rotation
                if uiTransform.zIndex ~= nil then
                    frame.frame.ZIndex = uiTransform.zIndex
                end
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
            labelInstance.TextTruncate = "AtEnd"
            Sunshine:addInstance(labelInstance, entity)
            if parent then
                local parentEntity = Sunshine:getEntity(parent.parent, entity.core.scene)
                if parentEntity then
                    local parentFrame = parentEntity.frame
                    local parentLabel = parentEntity.label
                    local parentScroll = parentEntity.scrollingFrame
                    if parentFrame then
                        labelInstance.Parent = parentFrame.frame
                    elseif parentLabel then
                        labelInstance.Parent = parentLabel.label
                    elseif parentScroll then
                        labelInstance.Parent = parentScroll.frame
                    end
                else
                    labelInstance.Parent = Sunshine.gui
                end
            else
                labelInstance.Parent = Sunshine.gui
            end
            local originalSize = label.size
            Sunshine:update(function()
                labelInstance.Position = uiTransform.position
                labelInstance.Font = label.font
                labelInstance.Size = UDim2.new(originalSize.X.Scale * uiTransform.size.X, originalSize.X.Offset *
                uiTransform.size.X, originalSize.Y.Scale * uiTransform.size.Y, originalSize.Y.Offset *
                uiTransform.size.Y)
                labelInstance.Rotation = uiTransform.rotation
                if uiTransform.zIndex ~= nil then
                    labelInstance.ZIndex = uiTransform.zIndex
                end
                labelInstance.AnchorPoint = uiTransform.anchorPoint
                labelInstance.Text = label.text
                labelInstance.TextColor3 = label.color
                labelInstance.TextStrokeTransparency = label.outlineTransparency 
                labelInstance.TextStrokeColor3 = label.outlineColor
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