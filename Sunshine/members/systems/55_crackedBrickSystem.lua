-- TrafficConeGod

return function(Sunshine, entity, scene)
    local startTick = nil
    local transform = entity.transform
    local collider = entity.collider
    local cracked = entity.cracked
    local spawn = entity.spawn
    local animator = entity.animator
    if transform and collider and cracked and animator then
        Sunshine:update(function()
            if collider.hitEntity and collider.hitEntity.character and not startTick then
                startTick = Sunshine:tick(scene)
            end
            if startTick then
                if Sunshine:tick(scene) - startTick > cracked.time then
                    Sunshine:destroyEntity(entity)
                else        
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