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
            if collider.hitEntity and collider.hitEntity.character and collider.hitEntity.character.controllable then
                character = collider.hitEntity
                camera = Sunshine:getEntity(character.input.camera, scene)
                character.animator.action = 1076799780
                character.character.controllable = false
                character.physics.movable = false
                character.transform.cFrame = CFrame.new(entity.transform.cFrame.Position, Vector3.new(
                camera.transform.cFrame.Position.X, entity.transform.cFrame.Y, camera.transform.cFrame.Position.Z))
                camera.camera.controllable = false
                camera.transform.cFrame = CFrame.new(CFrame.new(entity.transform.cFrame.Position, Vector3.new(
                camera.transform.cFrame.Position.X, entity.transform.cFrame.Y, camera.transform.cFrame.Position.Z))
                .LookVector*15, character.transform.cFrame.Position)
                sound.playing = true
                spinner.speed = 0
                startTick = Sunshine:tick(scene)
            end
            if startTick ~= nil and character and camera then
                if Sunshine:tick(scene) - startTick > 4 then
                    startTick = nil
                    character.physics.movable = true
                    character.character.controllable = true
                    camera.camera.controllable = true
                    Sunshine:destroyEntity(entity)
                elseif Sunshine:tick(scene) - startTick < 3 then
                    transform.cFrame = transform.cFrame:lerp(character.transform.cFrame + Vector3.new(0,6.5,0), Sunshine:tick(scene) -
                    startTick)
                end
            end
        end, entity)
    end
end