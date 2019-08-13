return function(Sunshine, entity)
    local uiListLayout = entity.uiListLayout
    local frame = entity.frame
    local scrollingFrame = entity.scrollingFrame

    if (frame or scrollingFrame) and uiListLayout then
        local listInstance = Instance.new("UIListLayout")
        listInstance.Padding = uiListLayout.padding
        Sunshine:addInstance(listInstance, entity)
        Sunshine:update(function()
            uiListLayout.instance = listInstance
            if frame then
                if frame.frame ~= nil then
                    listInstance.Parent = frame.frame
                end
            elseif scrollingFrame then
                if scrollingFrame.frame ~= nil then
                    listInstance.Parent = scrollingFrame.frame
                end
            end
        end, entity)
    end
end