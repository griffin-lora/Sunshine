local CollectionService = game:GetService("CollectionService")

return function(Sunshine, entity)
    local propertyButton = entity.propertyButton
    local parent = entity.parent

    if propertyButton and parent then
        local focusedScrollingFrame = Sunshine:getEntity("{8465CE6D-CB7D-4779-8BFE-0AA1C205E188}", entity.core.scene)
        --------------------------------------------------------------------------------------
        if propertyButton.type == "number" or propertyButton.type == "string" then
            ----------------------------------------------------------------------------------
            for _, propertyDescendant in pairs(entity.frame.frame:GetDescendants()) do
                if CollectionService:HasTag(propertyDescendant, "componentPropertyName") then
                    propertyDescendant.Text = Sunshine:camelCaseToTitleCase(propertyButton.propertyName)..":"
                elseif CollectionService:HasTag(propertyDescendant, "componentPropertyBox") then
                    --------------------------------------------------------------------------
                    propertyDescendant.PlaceholderText = propertyButton.default
                    if propertyButton.entity[propertyButton.componentName][propertyButton.propertyName] == nil then
                        propertyDescendant.Text = ""
                    else
                        propertyDescendant.Text = propertyButton.entity[propertyButton.componentName][propertyButton.propertyName]
                    end
                    local oldText = propertyDescendant.Text
                    --------------------------------------------------------------------------
                    Sunshine:addConnection(propertyDescendant.FocusLost, function()
                        if ((tonumber(propertyDescendant.Text) and propertyButton.type == "number") or propertyButton.type == "string") and propertyDescendant.Text ~= oldText then
                            changeManager.change.entity = propertyButton.entity
                            changeManager.change.componentName = name
                            changeManager.change.propertyName = name
                            if propertyButton.type == "number" then
                                changeManager.change.propertyValue = tonumber(propertyDescendant.Text)
                            else
                                changeManager.change.propertyValue = propertyDescendant.Text
                            end
                        else
                            propertyDescendant.Text = oldText
                        end
                    end, entity)
                end
            end
        else
            Sunshine:destroyEntity(entity)
        end
        focusedScrollingFrame.scrollingFrame.canvasSize = UDim2.new(0, 0, 0, focusedScrollingFrame.uiListLayout.instance.AbsoluteContentSize.Y)
    end
end