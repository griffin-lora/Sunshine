return function(Sunshine, entity)
    local visible = entity.visible
    local gameVisible = entity.gameVisible
    if visible and gameVisible then
        Sunshine:update(function()
            if Sunshine.scenes[1] then
                local player
                for _, otherEntity in pairs(Sunshine.scenes[1].entities) do
                    if otherEntity.tag and otherEntity.tag.tag == "player" then
                        player = otherEntity
                        break
                    end
                end
                visible.visible = not not player
            else
                visible.visible = false
            end
        end, entity)
    end
end