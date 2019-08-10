local Selection = game:GetService("Selection")
local CollectionService = game:GetService("CollectionService")
-- how do i install luacheck in ms paint

return function(Sunshine, entity)
    local deletableButtons = {}
    local scrollingFrame
    local componentEditor = entity.componentEditor
    local uiGridLayout

    if componentEditor then
        Sunshine:update(function()
            for _, sceneEntity in pairs(entity.core.scene.entities) do
                if sceneEntity.tag then
                    if sceneEntity.tag.tag == "componentsFrame" then
                        scrollingFrame = sceneEntity
                    end
                end
            end
            if scrollingFrame then
                if scrollingFrame.scrollingFrame.frame then
                    if not uiGridLayout then
                        uiGridLayout = Instance.new("UIGridLayout")
                        uiGridLayout.SortOrder = "Name"
                        uiGridLayout.CellSize = UDim2.new(0.5, -10, 0, 40)
                        uiGridLayout.Parent = scrollingFrame.scrollingFrame.frame
                        Sunshine:addInstance(uiGridLayout, entity)
                    end
                end
            end
        end, entity)
        Sunshine:addConnection(Selection.SelectionChanged, function()
            local selectedInstance = Selection:Get()[1]
            local selectedEntity
            if selectedInstance then
                for index, scene in pairs(Sunshine.scenes) do
                    if index > 1 then
                        for _, sceneEntity in pairs(scene.entities) do
                            for _, instance in pairs(sceneEntity.core.instances) do
                                if instance == selectedInstance then
                                    selectedEntity = sceneEntity
                                end
                            end
                        end
                    end
                end
            end
            if selectedEntity then
                local componentAmount = 0
                for _, sceneEntity in pairs(entity.core.scene.entities) do
                    if sceneEntity.tag then
                        if sceneEntity.tag.tag == "entitySelectedText" then
                            sceneEntity.label.text = "Selected "..selectedEntity.core.name
                        end
                    end
                end
                for _, buttonEntity in pairs(deletableButtons) do
                    Sunshine:destroyEntity(buttonEntity)
                end
                for name, component in pairs(selectedEntity) do
                    local button = Sunshine:createEntity({core = {name = "componentButton", id = game:GetService("HttpService"):GenerateGUID(true), active = true}, parent = {parent = "{7419E0EF-4D76-47C8-92B1-09F38E8A8F36}"}, frame = {frame = script.Parent.Parent.frames.componentButton}, tag = {tag = "componentButton"}, visible = {visible = false}, uiTransform = {position = UDim2.new(0, 5, 0, 5), size = Vector2.new(1, 1), rotation = 0, zIndex = 1, anchorPoint = Vector2.new(0, 0)}}, entity.core.scene)
                    for _, buttonDescendant in pairs(button.frame.frame:GetDescendants()) do
                        if CollectionService:HasTag(buttonDescendant, "componentName") then
                            buttonDescendant.Text = name
                        end
                    end
                    button.visible.visible = true
                    table.insert(deletableButtons, #deletableButtons+1, button)
                    componentAmount = componentAmount + 1
                end
                componentAmount = componentAmount/2
                if componentAmount%2 ~= 0 then
                    componentAmount = componentAmount + 1
                end
                scrollingFrame.scrollingFrame.canvasSize = UDim2.new(0, 0, 0, (40*(componentAmount))+10)
            else
                for _, sceneEntity in pairs(entity.core.scene.entities) do
                    if sceneEntity.tag then
                        if sceneEntity.tag.tag == "entitySelectedText" then
                            sceneEntity.label.text = "No entity selected!"
                        end
                    end
                end
                for _, buttonEntity in pairs(deletableButtons) do
                    Sunshine:destroyEntity(buttonEntity)
                end
            end
        end, entity)
    end
end