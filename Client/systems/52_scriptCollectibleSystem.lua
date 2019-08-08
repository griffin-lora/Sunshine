return function(Sunshine, entity)
    local scriptCollectible = entity.scriptCollectible
    local transform =  entity.transform
    local sound = entity.sound
    local collider = entity.collider
    local spinner = entity.spinner
    local pausedEntities = {}

    if scriptCollectible and sound and collider then
        local startTick
        local character
        local camera
        Sunshine:update(function()
            for _,hitEntity in pairs(collider.hitEntities) do
                if hitEntity and hitEntity.character and
                hitEntity.character.controllable and collider.trigger then
                    scriptCollectible.active = true
                    character = hitEntity
                    camera = Sunshine:getEntity(character.input.camera, entity.core.scene)
                    character.animator.action = 1076799780
                    character.input.moveVector = Vector3.new(0,0,0)
                    character.character.controllable = false
                    character.physics.velocity = Vector3.new(0,0,0)
                    character.physics.movable = false
                    character.health.health = 3
                    character.transform.cFrame = CFrame.new(transform.cFrame.Position, Vector3.new(
                    camera.transform.cFrame.Position.X, transform.cFrame.Y, camera.transform.cFrame.Position.Z))
                    transform.cFrame = character.transform.cFrame + Vector3.new(0, 6.5, 0)
                    camera.camera.controllable = false
                    camera.transform.cFrame = CFrame.new(transform.cFrame.Position +
                    (transform.cFrame.LookVector.Unit * 20) + Vector3.new(0, 10, 0),
                    transform.cFrame.Position)
                    sound.playing = true
                    spinner.speed = 0
                    startTick = entity.core.tick
                    for _,p in pairs(entity.core.scene.entities) do
                        local otherEntity = Sunshine:getEntity(p, entity.core.scene)
                        if otherEntity.core.id ~= character.core.id and otherEntity.core.id ~= camera.core.id and
                        otherEntity.core.id ~= entity.core.id then
                            table.insert(pausedEntities, #pausedEntities+1, {p, otherEntity.core.active or false})
                            if otherEntity.music then
                                otherEntity.music.paused = true
                            end
                            otherEntity.core.active = false
                        end
                    end
                end
            end
            if startTick ~= nil and character and camera then
                if entity.core.tick - startTick > 3.3 then
                    startTick = nil
                    character.physics.movable = true
                    character.animator.action = nil
                    character.character.controllable = true
                    camera.camera.controllable = true
                    for _,p in pairs(pausedEntities) do
                        local otherEntity = Sunshine:getEntity(p[1], entity.core.scene)
                        if otherEntity then
                            if otherEntity.music then
                                otherEntity.music.paused = false
                            end
                            otherEntity.core.active = p[2]
                        end
                    end
                    Sunshine:destroyEntity(entity)
                end
            end
        end, entity)
    end
end