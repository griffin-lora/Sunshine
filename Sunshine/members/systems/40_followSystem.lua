return function(Sunshine, entity)
    local transform = entity.transform
    local character = entity.character
    if transform and character then
        Sunshine:update(function()
            local player
            for _, entity in pairs(Sunshine.scene.entities) do
                if entity.tag and entity.tag.tag == "player" then
                    player = entity
                    break
                end
            end
            local mainCharacter = Sunshine:getEntity(player.player.character)
            if not mainCharacter.controllable then
                -- character.moveVector = (mainCharacter.transform.cFrame.Position - transform.cFrame.Position).Unit
            else
                character.moveVector = nil
            end
        end, entity)
    end
end