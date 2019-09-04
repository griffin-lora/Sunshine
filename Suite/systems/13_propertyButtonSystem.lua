local CollectionService = game:GetService("CollectionService")

return function(Sunshine, entity)
    local propertyButton = entity.propertyButton
    local parent = entity.parent

    if propertyButton and parent then
        local changeManager
        local bool = true
        local focusedScrollingFrame = Sunshine:getEntity("{8465CE6D-CB7D-4779-8BFE-0AA1C205E188}", entity.core.scene)
        --------------------------------------------------------------------------------------
        Sunshine:update(function()
            if not changeManager then
                for _, otherEntity in pairs(Sunshine.scenes[1].entities) do
                    if otherEntity.tag and otherEntity.tag.tag == "changeManager" then
                        changeManager = otherEntity
                        break
                    end
                end
            end
        end, entity)
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
                            changeManager.change.componentName = propertyButton.componentName
                            changeManager.change.propertyName = propertyButton.propertyName
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
        elseif propertyButton.type == "boolean" then
            bool = propertyButton.entity[propertyButton.componentName][propertyButton.propertyName]
            for _, propertyDescendant in pairs(entity.frame.frame:GetDescendants()) do
                if CollectionService:HasTag(propertyDescendant, "componentPropertyName") then
                    propertyDescendant.Text = Sunshine:camelCaseToTitleCase(propertyButton.propertyName)..":"
                elseif CollectionService:HasTag(propertyDescendant, "booleanButton") then
                    --------------------------------------------------------------------------
                    if propertyButton.entity[propertyButton.componentName][propertyButton.propertyName] == false then
                        propertyDescendant.ImageTransparency = 1
                    else
                        propertyDescendant.ImageTransparency = 0
                    end
                    --------------------------------------------------------------------------
                    Sunshine:addConnection(propertyDescendant.MouseButton1Click, function()
                        changeManager.change.entity = propertyButton.entity
                        changeManager.change.componentName = propertyButton.componentName
                        changeManager.change.propertyName = propertyButton.propertyName
                        changeManager.change.propertyValue = not bool
                        bool = not bool
                        propertyDescendant.ImageTransparency = bool and 0 or 1
                    end, entity)
                end
            end
        else
            Sunshine:destroyEntity(entity)
        end
        focusedScrollingFrame.scrollingFrame.canvasSize = UDim2.new(0, 0, 0, focusedScrollingFrame.uiListLayout.instance.AbsoluteContentSize.Y)
    end
end