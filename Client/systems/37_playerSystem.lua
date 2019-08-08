local CFRAME_NEW = CFrame.new

return function(Sunshine, entity)
    local player = entity.player
    if player then
        local lastCharacter
        Sunshine:update(function()
            local mainCharacter = Sunshine:getEntity(player.mainCharacter, entity.core.scene)
            local character = Sunshine:getEntity(player.character, entity.core.scene)
            local camera = Sunshine:getEntity(player.camera, entity.core.scene)
            if mainCharacter and character and camera then
                character.character.player = entity
                character.input.camera = camera
                camera.camera.subject = character
                if character ~= mainCharacter then
                    mainCharacter.transform.cFrame = CFRAME_NEW(0, 100000, 0)
                    mainCharacter.physics.movable = false
                    mainCharacter.character.controllable = false
                    character.character.controllable = true
                    character.capture.active = true
                    character.respawner.active = false
                    if character.follow then
                        character.follow.active = false
                    end
                end
                if lastCharacter and lastCharacter.capture and lastCharacter ~= character and
                character == mainCharacter then
                    lastCharacter.capture.active = false
                    lastCharacter.respawner.active = true
                    lastCharacter.character.controllable = false
                    character.physics.movable = true
                    character.character.controllable = true
                    character.character.state = "bounce"
                    character.transform.cFrame = lastCharacter.transform.cFrame + Vector3.new(0, 10, 0)
                end
                lastCharacter = character
            end
        end, entity)
    end
end