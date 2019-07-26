-- TrafficConeGod

return function(Sunshine, entity)
    local startTick = nil
    local active = false
    local transform = entity.transform
    local transparency = entity.transparency
    local collider = entity.collider
    local cracked = entity.cracked
    local animator = entity.animator
    local respawner = entity.respawner
    if transform and collider and cracked and animator and respawner and transparency then
        Sunshine:update(function()
            if collider.hitEntity and collider.hitEntity.character and not startTick and not active then
                startTick = entity.core.tick
            end
            if startTick then
                if entity.core.tick - startTick >= cracked.time then
                    active = true
                    startTick = nil
                    transform.cFrame = CFrame.new(0,100000000,0)
                    respawner.active = true
                else
                    local slow = 500
                    if cracked.instant then
                        slow = 250
                    end
                    if cracked.animation ~= nil then
                        animator.action = cracked.animation
                    end
                    transform.cFrame = transform.cFrame:lerp(transform.cFrame - Vector3.new(0, 100, 0),
                    (entity.core.tick - startTick) / slow)
                end
            end
        end, entity)
    end
end