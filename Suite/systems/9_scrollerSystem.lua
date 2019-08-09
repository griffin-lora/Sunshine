return function(Sunshine, entity)
    local scroller = entity.scroller
    local frame = entity.frame
    local startTick = entity.core.tick
    local originalPosition

    if scroller and frame then
        Sunshine:update(function()
            if entity.core.tick - startTick >= 1 then
                startTick = entity.core.tick
            end
            local time = entity.core.tick - startTick
            for _,label in pairs(frame.frame:GetDescendants()) do
                if label:IsA("ImageLabel") then
                    if not originalPosition then
                        originalPosition = label.Position
                    end
                    if scroller.axis == "x" then
                        label.Position = UDim2.new(
                        originalPosition.X.Scale, 
                        Sunshine:tween(time, scroller.tweenInfo, originalPosition.X.Offset, originalPosition.X.Offset + scroller.amount), 
                        originalPosition.Y.Scale, 
                        originalPosition.Y.Offset
                        )
                    elseif scroller.axis == "y" then
                        label.Position = UDim2.new(
                        originalPosition.X.Scale, 
                        originalPosition.X.Offset, 
                        originalPosition.Y.Scale,
                        Sunshine:tween(time, scroller.tweenInfo, originalPosition.Y.Offset, originalPosition.Y.Offset + scroller.amount)
                        )
                    else
                        label.Position = UDim2.new(
                        originalPosition.X.Scale, 
                        Sunshine:tween(time, scroller.tweenInfo, originalPosition.X.Offset, originalPosition.X.Offset + scroller.amount),
                        originalPosition.Y.Scale,
                        Sunshine:tween(time, scroller.tweenInfo, originalPosition.Y.Offset, originalPosition.Y.Offset + scroller.amount)
                        )
                    end
                end
            end
        end, entity)
    end
end