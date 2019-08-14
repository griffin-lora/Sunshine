local Selection = game:GetService("Selection")
local CollectionService = game:GetService("CollectionService")
-- how do i install luacheck in ms paint

return function(Sunshine, entity)
    local deletableButtons = {}
    local deletableFocusedButtons = {}
    local scrollingFrame
    local componentEditor = entity.componentEditor
    local tag = entity.tag
    local uiGridLayout
    local componentFocused = false

    if componentEditor then
        local changeManager
        Sunshine:update(function()
            if not changeManager then
                for _, otherEntity in pairs(Sunshine.scenes[1].entities) do
                    if otherEntity.tag and otherEntity.tag.tag == "changeManager" then
                        changeManager = otherEntity
                        break
                    end
                end
            end
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
                componentFocused = false
                for _, sceneEntity in pairs(entity.core.scene.entities) do
                    if sceneEntity.tag then
                        if sceneEntity.tag.tag == "entitySelectedText" then
                            sceneEntity.label.text = "Selected "..selectedEntity.core.name
                        elseif sceneEntity.tag.tag == "focusedComponentFrame" then
                            sceneEntity.visible.visible = false
                        elseif sceneEntity.tag.tag == "componentBackButton" then
                            sceneEntity.visible.visible = false
                        elseif sceneEntity.tag.tag == "componentsFrame" then
                            sceneEntity.visible.visible = true
                        end
                    end
                end
                for _, buttonEntity in pairs(deletableButtons) do
                    Sunshine:destroyEntity(buttonEntity)
                end
                for _, buttonEntity in pairs(deletableFocusedButtons) do
                    Sunshine:destroyEntity(buttonEntity)
                end
                for name, _ in pairs(componentEditor.components) do
                    if selectedEntity[name] then
                        local button = Sunshine:createEntity({
                            core = {
                                name = "componentButton",
                                id = game:GetService("HttpService"):GenerateGUID(true),
                                active = true
                            },
                            parent = {
                                parent = "{7419E0EF-4D76-47C8-92B1-09F38E8A8F36}"
                            },
                            frame = {
                                frame = script.Parent.Parent.frames.componentButton
                            },
                            tag = {
                                tag = "componentButton"
                            },
                            visible = {
                                visible = false
                            },
                            uiTransform = {
                                position = UDim2.new(0, 5, 0, 5), size = Vector2.new(1, 1),
                                rotation = 0,
                                zIndex = 1,
                                anchorPoint = Vector2.new(0, 0)
                            }}, entity.core.scene)
                        for _, buttonDescendant in pairs(button.frame.frame:GetDescendants()) do
                            if CollectionService:HasTag(buttonDescendant, "componentName") then
                                buttonDescendant.Text = Sunshine:camelCaseToTitleCase(name)
                            elseif CollectionService:HasTag(buttonDescendant, "componentButton") then
                                Sunshine:addConnection(buttonDescendant.Activated, function()
                                    componentFocused = true
                                    for _, sceneEntity in pairs(entity.core.scene.entities) do
                                        if sceneEntity.tag then
                                            if sceneEntity.tag.tag == "focusedComponentFrame" then
                                                sceneEntity.visible.visible = true
                                                for _, descendant in pairs(sceneEntity.frame.frame:GetDescendants()) do 
                                                    if CollectionService:HasTag(descendant, "focusedComponentText") then
                                                        descendant.Text = Sunshine:camelCaseToTitleCase(name)
                                                    end
                                                end
                                            elseif sceneEntity.tag.tag == "componentBackButton" then
                                                sceneEntity.visible.visible = true
                                            elseif sceneEntity.tag.tag == "componentsFrame" then
                                                sceneEntity.visible.visible = false
                                            end
                                        end
                                    end
                                    for _, buttonEntity in pairs(deletableFocusedButtons) do
                                        Sunshine:destroyEntity(buttonEntity)
                                    end
                                    for focusedName, focusedValue in pairs(componentEditor.components[name]) do
                                        local frameInstance = script.Parent.Parent.frames.componentProperty
                                        local propertyButton = Sunshine:createEntity({
                                            core = {
                                                name = "componentProperty",
                                                id = game:GetService("HttpService"):GenerateGUID(true),
                                                active = true
                                            },
                                            parent = {
                                                parent = "{8465CE6D-CB7D-4779-8BFE-0AA1C205E188}"
                                            },
                                            frame = {
                                                frame = frameInstance
                                            },
                                            tag = {
                                                tag = "componentProperty"
                                            },
                                            visible = {
                                                visible = true
                                            },
                                            propertyButton = {
                                                type = focusedValue.type,
                                                default = focusedValue.default,
                                                propertyName = focusedName,
                                                componentName = name,
                                                entity = selectedEntity
                                            },
                                            uiTransform = {
                                                position = UDim2.new(0, 5, 0, 5), size = Vector2.new(1, 1),
                                                rotation = 0,
                                                zIndex = nil,
                                                anchorPoint = Vector2.new(0, 0)
                                        }}, entity.core.scene)
                                        table.insert(deletableFocusedButtons, #deletableFocusedButtons+1, propertyButton)
                                    end
                                end, entity)
                            end
                        end
                        button.visible.visible = true
                        table.insert(deletableButtons, #deletableButtons+1, button)
                    end
                end
                scrollingFrame.scrollingFrame.canvasSize = UDim2.new(0, 0, 0, uiGridLayout.AbsoluteContentSize.Y)
            else
                componentFocused = false
                for _, sceneEntity in pairs(entity.core.scene.entities) do
                    if sceneEntity.tag then
                        if sceneEntity.tag.tag == "entitySelectedText" then
                            sceneEntity.label.text = "No entity selected!"
                        elseif sceneEntity.tag.tag == "focusedComponentFrame" then
                            sceneEntity.visible.visible = false
                        elseif sceneEntity.tag.tag == "componentBackButton" then
                            sceneEntity.visible.visible = false
                        elseif sceneEntity.tag.tag == "componentsFrame" then
                            sceneEntity.visible.visible = true
                        end
                    end
                end
                for _, buttonEntity in pairs(deletableButtons) do
                    Sunshine:destroyEntity(buttonEntity)
                end
                for _, buttonEntity in pairs(deletableFocusedButtons) do
                    Sunshine:destroyEntity(buttonEntity)
                end
            end
        end, entity)
    elseif tag then
        if tag.tag == "componentBackButton" then
            Sunshine:update(function()
                if entity.button.activated then
                    componentFocused = false
                    for _, buttonEntity in pairs(deletableFocusedButtons) do
                        Sunshine:destroyEntity(buttonEntity)
                    end
                    for _, sceneEntity in pairs(entity.core.scene.entities) do
                        if sceneEntity.tag then
                            if sceneEntity.tag.tag == "focusedComponentFrame" then
                                sceneEntity.visible.visible = false
                            elseif sceneEntity.tag.tag == "componentBackButton" then
                                sceneEntity.visible.visible = false
                            elseif sceneEntity.tag.tag == "componentsFrame" then
                                sceneEntity.visible.visible = true
                            end
                        end
                    end
                end
            end, entity)
        end
    end
end