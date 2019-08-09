local Selection = game:GetService("Selection")

return function(Sunshine, entity)
    local componentEditor = entity.componentEditor
    if componentEditor then
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
                print(selectedEntity.core.id)
            else
                print("failed bruhm")
            end
        end, entity)
    end
end