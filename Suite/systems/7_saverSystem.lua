local Selection = game:GetService("Selection")

return function(Sunshine, entity)
    local saver = entity.saver
    local button = entity.button
    if saver and button then
        Sunshine:update(function()
            if button.activated then
                for index, scene in pairs(Sunshine.scenes) do
                    if index > 1 then
                        local dataScene = {entities = {}}
                        for _, sceneEntity in pairs(scene.entities) do
                            local dataEntity = {core = {id = sceneEntity.core.id, name = sceneEntity.core.name, active =
                            sceneEntity.core.active}}
                            for name, component in pairs(sceneEntity) do
                                if name ~= "core" then
                                    local dataComponent = {}
                                    for propertyName, value in pairs(component) do
                                        if type(value) == "table" then
                                            print(propertyName,value)
                                            dataComponent[propertyName] = Sunshine:cloneTable(value)
                                        else
                                            dataComponent[propertyName] = value
                                        end
                                    end
                                    if name == "transform" then
                                        dataComponent.cFrame = component.cFrame
                                    end
                                    dataEntity[name] = dataComponent
                                end
                            end
                            dataScene.entities[#dataScene.entities + 1] = dataEntity
                        end
                        print(Sunshine:encodeTable(dataScene))
                    end
                end
            end
        end, entity)
    end
end