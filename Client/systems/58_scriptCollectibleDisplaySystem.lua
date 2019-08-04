local CollectionService = game:GetService("CollectionService")

return function(Sunshine, entity)
    local scriptCollectibleDisplay = entity.scriptCollectibleDisplay
    local frame = entity.frame
    local visible = entity.visible
    if scriptCollectibleDisplay and frame and visible then
        local scriptCollectible
        Sunshine:update(function()
            if Sunshine.scenes[1] then
                for _, otherEntity in pairs(Sunshine.scenes[1].entities) do
                    if otherEntity.scriptCollectible and otherEntity.scriptCollectible.active then
                        scriptCollectible = otherEntity
                    end
                end
                if scriptCollectible and scriptCollectible.core.active then
                    local date = os.date("*t", os.time())
                    for _,p in pairs(frame.frame:GetDescendants()) do
                        if CollectionService:HasTag(p, "collectibleNameLabel") then
                            p.Text = scriptCollectible.scriptCollectible.name
                        elseif CollectionService:HasTag(p, "collectibleDateLabel") then
                            p.Text = date.month .. "/" .. date.day .. "/" .. date.year
                        end
                    end
                    visible.visible = true
                else
                    visible.visible = false
                end
            end
        end, entity)
    end
end