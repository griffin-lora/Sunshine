return function(Sunshine, entity)
    local scriptCollectibleDisplay = entity.scriptCollectibleDisplay
    if scriptCollectibleDisplay then
        local scriptCollectible
        Sunshine:update(function()
            local frame = Sunshine:getEntity(scriptCollectibleDisplay.frame, entity.core.scene)
            local nameLabel = Sunshine:getEntity(scriptCollectibleDisplay.nameLabel, entity.core.scene)
            local dateLabel = Sunshine:getEntity(scriptCollectibleDisplay.dateLabel, entity.core.scene)
            if frame and nameLabel and dateLabel then
                for _, otherEntity in pairs(Sunshine.scenes[1].entities) do
                    if otherEntity.scriptCollectible and otherEntity.scriptCollectible.active then
                        scriptCollectible = otherEntity
                    end
                end
                if scriptCollectible and scriptCollectible.core.active then
                    nameLabel.label.text = scriptCollectible.scriptCollectible.name
                    local date = os.date("*t", os.time())
                    dateLabel.label.text = date.month .. "/" .. date.day .. "/" .. date.year
                    frame.visible.visible = true
                    nameLabel.visible.visible = true
                    dateLabel.visible.visible = true
                else
                    frame.visible.visible = false
                    nameLabel.visible.visible = false
                    dateLabel.visible.visible = false
                end
            end
        end, entity)
    end
end