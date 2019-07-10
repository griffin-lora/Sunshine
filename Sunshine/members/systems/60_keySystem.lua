return function(Sunshine, entity, scene)
    local key = entity.key
    local collider = entity.collider
    local spinner = entity.spinner
    local transparency = entity.transparency
    local oscillator = entity.oscillator
    local transform = entity.transform
    local respawner = entity.respawner
    local startTick
    local collected = false
    local completed = false
    if key and collider and spinner and transparency and oscillator and transform and respawner then
        local oldFrame = transform.cFrame
        local script = Sunshine:getEntity(key.scriptCollectible, scene)
        if script then
            if script.spinner.speed ~= 0 then
                script.transparency.transparency = 1
                script.scriptCollectible.active = false
                Sunshine:update(function()
                    if not script then
                        Sunshine:destroyEntity(entity)
                    end
                    if collider.hitEntity and collider.hitEntity.character and collider.hitEntity.character.player and not collected then
                        oscillator.axis = nil
                        spinner.speed = 25
                        collected = true
                        startTick = Sunshine:tick(scene)
                    elseif collected and startTick and Sunshine:tick(scene) - startTick <= 1 then
                        local newFrame = oldFrame + Vector3.new(0,2,0)
                        transform.cFrame = transform.cFrame:lerp(newFrame, Sunshine:tick(scene) - startTick)
                    elseif collected and not completed then
                        transparency.transparency = 1
                        spinner.speed = 0
                        script.transparency.transparency = 0
                        script.scriptCollectible.active = true
                        respawner.active = true
                        completed = true
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