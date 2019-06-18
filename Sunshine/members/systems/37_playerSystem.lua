return function(Sunshine, entity)
    local player = entity.player
    if player then
        local lastCharacter
        Sunshine:update(function()
            local mainCharacter = Sunshine:getEntityById(player.mainCharacter)
            local character = Sunshine:getEntityById(player.character)
            local camera = Sunshine:getEntityById(player.camera)
            if mainCharacter and character and camera then
                character.character.player = entity
                character.input.camera = camera.core.id
                camera.camera.subject = character.core.id
                if character ~= mainCharacter then
                    mainCharacter.transform.cFrame = CFrame.new(0, 100000, 0)
                    mainCharacter.physics.movable = false
                    mainCharacter.character.controllable = false
                    character.character.controllable = true
                    character.capture.active = true
                end
                if lastCharacter and lastCharacter ~= character and character == mainCharacter then
                    lastCharacter.capture.active = false
                    lastCharacter.character.controllable = false
                    character.physics.movable = true
                    character.character.controllable = true
                    character.transform.cFrame = lastCharacter.transform.cFrame + Vector3.new(0, 10, 0)
                end
                lastCharacter = character
            end
        end, entity)
    end
end