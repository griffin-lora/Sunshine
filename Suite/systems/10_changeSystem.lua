return function(Sunshine, entity)
    local change = entity.change
    if change then
        Sunshine:update(function()
            if change.entity then
                if not change.alreadyChangedOnEntity then
                    change.entity[change.componentName][change.propertyName] = change.propertyValue
                end
                change.entity.core.dataEntity[change.componentName][change.propertyName] = change.propertyValue
                change.entity.core.scene.instance.Source = "return " .. Sunshine:encodeTable(Sunshine.dataScenes
                [change.entity.core.scene.index])
                change.entity = nil
                change.componentName = nil
                change.propertyName = nil
                change.propertyValue = nil
                change.alreadyChangedOnEntity = nil
            end
        end, entity)
    end
end