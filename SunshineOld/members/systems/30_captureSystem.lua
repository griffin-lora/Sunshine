return function(Sunshine, entity)
    local capture = entity.capture
    local character = entity.character
    local input = entity.input
    local transform = entity.transform
    local health = entity.health
    local respawner = entity.respawner
    if capture and character and input and transform and health and respawner then
        Sunshine:update(function()
            if capture.active then
                if input.shift or health.health <= 0 then
                    local player = character.player
                    player.player.character = player.player.mainCharacter
                end
            end
        end, entity)
    end
end