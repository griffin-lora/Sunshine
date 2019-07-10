return function(Sunshine, entity, scene)
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
    local originalAngle
    if key and collider and spinner and transparency and oscillator and transform and respawner then
        local oldFrame = transform.cFrame
        local script = Sunshine:getEntity(key.scriptCollectible, scene)
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
                print(script.spinner.speed)
                script.collider.trigger = false
                Sunshine:update(function()
                    if not script then
                        Sunshine:destroyEntity(entity)
                    end
                    if not spawning then
                        if collider.hitEntity and collider.hitEntity.character and collider.hitEntity.character.player and not collected then
                            character = collider.hitEntity
                            oscillator.axis = nil
                            spinner.speed = 25
                            collected = true
                            startTick = Sunshine:tick(scene)
                            local player = Sunshine:getEntity(character.character.player, scene)
                            if player then
                                camera = Sunshine:getEntity(player.player.camera, scene)
                            end
                        elseif collected and startTick and Sunshine:tick(scene) - startTick <= 1 then
                            local newFrame = oldFrame + Vector3.new(0, 3, 0)
                            transform.cFrame = transform.cFrame:lerp(newFrame, (Sunshine:tick(scene) - startTick)/5)
                            transform.size = transform.size:lerp(Vector3.new(0, 0, 0), (Sunshine:tick(scene) - startTick)/5)
                        elseif collected and not completed then
                            transparency.transparency = 1
                            spinner.speed = 0
                            script.transparency.transparency = 0
                            script.collider.trigger = true
                            respawner.active = true
                            completed = true
                            spawning = true
                            startTick2 = Sunshine:tick(scene)
                        end
                    else
                        if Sunshine:tick(scene) - startTick2 <= 2 then
                            camera.controllable = false
                            character.character.controllable = false
                            local currentFrame = (originalAngle * CFrame.Angles(0,math.pi,0)) + script.transform.cFrame.Position
                            camera.transform.cFrame = CFrame.new(currentFrame.Position + (currentFrame.LookVector*10), currentFrame.Position)
                            script.transform.cFrame = script.transform.cFrame:lerp(lerpToScript, (Sunshine:tick(scene) - startTick2)/45)
                            script.transform.size = script.transform.size:lerp(lerpToSize, (Sunshine:tick(scene) - startTick2)/45)
                        else
                            script.transform.cFrame = lerpToScript
                            script.transform.size = lerpToSize
                            camera.controllable = true
                            character.character.controllable = true
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