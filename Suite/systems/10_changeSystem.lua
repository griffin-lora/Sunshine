return function(Sunshine, entity)
    local change = entity.change
    if change then
        local function handleChange(changedEntity, componentName, propertyName, propertyValue, alreadyChangedOnEntity)
            if not alreadyChangedOnEntity then
                changedEntity[componentName][propertyName] = propertyValue
            end
            if not changedEntity.core.dataEntity[componentName] then
                changedEntity.core.dataEntity[componentName] = {}
            end
            changedEntity.core.dataEntity[componentName][propertyName] = propertyValue
            changedEntity.core.scene.instance.Source = "return " .. Sunshine:encodeTable(Sunshine.dataScenes
            [changedEntity.core.scene.index])
        end
        Sunshine:update(function()
            if change.entity then
                change.teamCreateUpdate = false
                handleChange(change.entity, change.componentName, change.propertyName, change.propertyValue,
                change.alreadyChangedOnEntity)
                if Sunshine.PluginNetworkClient.isEnabled() then
                    Sunshine.PluginNetworkClient:fireAllClients(change.entity.core.scene.instance,
                    change.entity.core.id, change.componentName, change.propertyName, change.propertyValue)
                end
                change.entity = nil
                change.componentName = nil
                change.propertyName = nil
                change.propertyValue = nil
                change.alreadyChangedOnEntity = nil
            end
        end, entity)
        local index = Sunshine.PluginNetworkClient:onClientEvent(function(_, sceneInstance, entityId,
            componentName, propertyName, propertyValue)
            for _, scene in pairs(Sunshine.scenes) do
                if scene.instance == sceneInstance then
                    local changedEntity = Sunshine:getEntityById(entityId, scene)
                    change.teamCreateUpdate = true
                    handleChange(changedEntity, componentName, propertyName, propertyValue)
                end
            end
        end)
        Sunshine:entityDestroy(function()
            Sunshine.PluginNetworkClient:removeClientEvent(index)
        end, entity)
    end
end