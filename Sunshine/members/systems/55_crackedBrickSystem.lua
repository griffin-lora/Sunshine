-- TrafficConeGod

return function(Sunshine, entity, scene)
    local startTick = nil
    local ded = false
    local transform = entity.transform
    local collider = entity.collider
    local cracked = entity.cracked
    local animator = entity.animator
    local respawner = entity.respawner
    if transform and collider and cracked and animator and respawner then
        Sunshine:update(function()
            if collider.hitEntity and collider.hitEntity.character and not startTick and not ded then
                startTick = Sunshine:tick(scene)
            end
            if startTick then
                if Sunshine:tick(scene) - startTick >= cracked.time then
                    ded = true
                    startTick = nil
                    transform.cFrame = CFrame.new(0,100000000,0)
                    respawner.active = true
                else
                    print(Sunshine:tick(scene) - startTick)
                    local slow = 500
                    if cracked.instant then
                        slow = 250
                    end
                    if cracked.animation ~= nil then
                        animator.action = cracked.animation
                    end
                    transform.cFrame = transform.cFrame:lerp(transform.cFrame - Vector3.new(0, 100, 0), (Sunshine:tick(scene) - startTick)/slow)
                end
            end
        end, entity)
    end
end