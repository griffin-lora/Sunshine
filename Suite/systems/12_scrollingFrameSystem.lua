return function(Sunshine, entity)
    local scrollingFrame = entity.scrollingFrame
    local uiTransform = entity.uiTransform
    local visible = entity.visible
    local parent = entity.parent

    if scrollingFrame and uiTransform then
        local frameInstance = Instance.new("ScrollingFrame")
        frameInstance.ScrollingDirection = scrollingFrame.scrollingDirection
        frameInstance.BackgroundTransparency = 1
        frameInstance.BorderSizePixel = 0
        
        Sunshine:addInstance(frameInstance, entity)
        local originalSize = scrollingFrame.size
        Sunshine:update(function()
            scrollingFrame.frame = frameInstance
            if visible then
                frameInstance.Visible = visible.visible
            end
            if parent then
                local parentEntity = Sunshine:getEntity(parent.parent, entity.core.scene)
                if parentEntity then
                    local parentFrame = parentEntity.frame
                    local parentLabel = parentEntity.label
                    local parentWidget = parentEntity.widget
                    local parentScroll = parentEntity.scrollingFrame
                    if parentFrame then
                        frameInstance.Parent = parentFrame.frame
                    elseif parentLabel then
                        frameInstance.Parent = parentLabel.label
                    elseif parentWidget then
                        frameInstance.Parent = parentWidget.widget
                    elseif parentScroll then
                        frameInstance.Parent = parentScroll.frame
                    end
                else
                    frameInstance.Parent = Sunshine.gui
                end
            else
                frameInstance.Parent = Sunshine.gui
            end
            frameInstance.Position = uiTransform.position
            frameInstance.Size = UDim2.new(originalSize.X.Scale * uiTransform.size.X, originalSize.X.Offset *
            uiTransform.size.X, originalSize.Y.Scale * uiTransform.size.Y, originalSize.Y.Offset * uiTransform.size.Y)
            frameInstance.CanvasSize = scrollingFrame.canvasSize
            frameInstance.Rotation = uiTransform.rotation
            frameInstance.ZIndex = uiTransform.zIndex
            frameInstance.AnchorPoint = uiTransform.anchorPoint
        end, entity)
    end
end