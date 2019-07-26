return function(Sunshine, entity)
    local crackedWall = entity.crackedWall
    local collider = entity.collider
    local animator = entity.animator
    local physics = entity.physics
    local wait = false
    local startTick
    if collider and crackedWall and animator and physics then
        Sunshine:update(function()
            if collider.hitEntity and collider.hitEntity.character and collider.hitEntity.character.state == "dash" and
            not wait then
                physics.canCollide = false
                wait = true
                startTick = entity.core.tick
                if crackedWall.animation ~= nil then
                    animator.action = crackedWall.animation
                end
            end
            if wait and entity.core.tick - startTick >= crackedWall.time then
                Sunshine:destroyEntity(entity)
            end
        end, entity)
    end
end