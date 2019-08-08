return function(Sunshine, entity)
    local key = entity.key
    local collider = entity.collider
    local spinner = entity.spinner
    local transparency = entity.transparency
    local oscillator = entity.oscillator
    local transform = entity.transform
    local respawner = entity.respawner
    local startTick
    local startTick2
    local camera
    local character
    local collected = false
    local completed = false
    local spawning = false
    local pausedEntities = {}
    local originalAngle
    if key and collider and spinner and transparency and oscillator and transform and respawner then
        local oldFrame = transform.cFrame
        local script = Sunshine:getEntity(key.scriptCollectible, entity.core.scene)
        if script then
            script.spinner.speed = 0
            if originalAngle then
                script.transform.cFrame = originalAngle + script.transform.cFrame.Position
            end
            if script.scriptCollectible.active == false then
                local lerpToScript = script.transform.cFrame
                local lerpToSize = script.transform.size
                originalAngle = script.transform.cFrame - script.transform.cFrame.Position
                script.transform.size = Vector3.new(0, 0, 0)
                script.transform.cFrame = script.transform.cFrame - Vector3.new(0, 2, 0)
                script.transparency.transparency = 1
                script.spinner.speed = 1
                script.collider.trigger = false
                Sunshine:update(function()
                    if not script then
                        Sunshine:destroyEntity(entity)
                    end
                    if not spawning then
                        for _,hitEntity in pairs(collider.hitEntities) do
                            if hitEntity and hitEntity.character and hitEntity.character.player and not collected then
                                character = hitEntity
                                oscillator.axis = nil
                                spinner.speed = 25
                                collected = true
                                startTick = entity.core.tick
                                key.active = true
                                camera = Sunshine:getEntity(character.input.camera, entity.core.scene)
                                for _,p in pairs(entity.core.scene.entities) do
                                    local otherEntity = Sunshine:getEntity(p, entity.core.scene)
                                    if otherEntity.core.id ~= script.core.id and otherEntity.core.id ~= camera.core.id and otherEntity.core.id ~= entity.core.id then
                                        table.insert(pausedEntities, #pausedEntities+1, {p, otherEntity.core.active or false})
                                        otherEntity.core.active = false
                                    end
                                end
                            end
                        end
                        if collected and startTick and entity.core.tick - startTick <= 1 then
                            local newFrame = oldFrame + Vector3.new(0, 3, 0)
                            transform.cFrame = transform.cFrame:lerp(newFrame, (entity.core.tick - startTick)/5)
                            transform.size = transform.size:lerp(Vector3.new(0, 0, 0), (entity.core.tick - startTick)/5)
                        elseif collected and not completed then
                            transparency.transparency = 1
                            spinner.speed = 0
                            script.transparency.transparency = 0
                            script.collider.trigger = true
                            respawner.active = true
                            completed = true
                            spawning = true
                            startTick2 = entity.core.tick
                        end
                    else
                        if entity.core.tick - startTick2 <= 2 then
                            camera.camera.controllable = false
                            character.input.moveVector = Vector3.new(0,0,0)
                            character.character.controllable = false
                            local currentFrame = (originalAngle * CFrame.Angles(0,math.pi,0)) + script.transform.cFrame.Position
                            camera.transform.cFrame = CFrame.new(currentFrame.Position + (currentFrame.LookVector*10), currentFrame.Position)
                            script.transform.cFrame = script.transform.cFrame:lerp(lerpToScript, (entity.core.tick - startTick2)/45)
                            script.transform.size = script.transform.size:lerp(lerpToSize, (entity.core.tick - startTick2)/45)
                        else
                            script.transform.cFrame = lerpToScript
                            script.transform.size = lerpToSize
                            camera.camera.controllable = true
                            character.character.controllable = true
                            key.active = false
                            for _,p in pairs(pausedEntities) do
                                local otherEntity = Sunshine:getEntity(p[1], entity.core.scene)
                                if otherEntity then
                                    otherEntity.core.active = p[2]
                                end
                            end
                            spawning = false
                        end
                    end
                end, entity)
            else
                Sunshine:destroyEntity(entity)
            end
        else
            Sunshine:destroyEntity(entity)
        end
    end
end