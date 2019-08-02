return function(Sunshine, entity, scene)
    local scriptCollectible = entity.scriptCollectible
    local transform =  entity.transform
    local sound = entity.sound
    local collider = entity.collider
    local spinner = entity.spinner
    if scriptCollectible and sound and collider then
        local startTick
        local character
        local camera
        Sunshine:update(function()
            if collider.hitEntity and collider.hitEntity.character and collider.hitEntity.character.controllable and collider.trigger then
                scriptCollectible.active = true
                character = collider.hitEntity
                camera = Sunshine:getEntity(character.input.camera, scene)
                character.animator.action = 1076799780
                character.character.controllable = false
                character.physics.movable = false
                character.transform.cFrame = CFrame.new(transform.cFrame.Position, Vector3.new(
                camera.transform.cFrame.Position.X, transform.cFrame.Y, camera.transform.cFrame.Position.Z))
                transform.cFrame = character.transform.cFrame + Vector3.new(0, 6.5, 0)
                camera.camera.controllable = false
                camera.transform.cFrame = CFrame.new(transform.cFrame.Position +
                (-transform.cFrame.LookVector.Unit * 20) + Vector3.new(0, 10, 0),
                transform.cFrame.Position)
                sound.playing = true
                spinner.speed = 0
                startTick = entity.core.tick
            end
            if startTick ~= nil and character and camera then
                if entity.core.tick - startTick > 4 then
                    startTick = nil
                    character.physics.movable = true
                    character.character.controllable = true
                    camera.camera.controllable = true
                    Sunshine:destroyEntity(entity)
                end
            end
        end, entity)
    end
end