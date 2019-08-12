-- Unused

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
                            dataScene.entities[#dataScene.entities + 1] = sceneEntity.core.dataEntity
                        end
                        scene.instance.Source = "return" .. Sunshine:encodeTable(dataScene)
                        print("Saved scene successfully!")
                    end
                end
            end
        end, entity)
    end
end