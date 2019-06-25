return function(Sunshine, entity)
    local spawn = entity.spawn
    local store = entity.store
    local transform = entity.transform
    if spawn and store and transform then
        local player
        local lastActive = true
        local loaded = false
        Sunshine:update(function()
            if store.save and not loaded then
                entity.spawn = store.save.spawn or spawn
                spawn = entity.spawn
                store.save.spawn = spawn
                loaded = true
            end
            if store.save then
                if not player then
                    for _, entity in pairs(Sunshine.scene.entities) do
                        if entity.tag and entity.tag.tag == "player" then
                            player = entity
                            break
                        end
                    end
                    if spawn.active then
                        local mainCharacter = Sunshine:getEntity(player.player.character)
                        mainCharacter.transform.cFrame = transform.cFrame
                    end
                end
                if spawn.active and spawn.active ~= lastActive then
                    for _, entity in pairs(Sunshine.scene.entities) do
                        local spawn = entity.spawn
                        if spawn then
                            spawn.active = false
                        end
                    end
                    spawn.active = true
                end
                lastActive = spawn.active
            end
        end, true)
    end
end