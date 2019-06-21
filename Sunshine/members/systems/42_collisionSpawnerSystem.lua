return function(Sunshine, entity)
    local collisionSpawner = entity.collisionSpawner
    local collider = entity.collider
    local spawner = entity.spawner
    if collisionSpawner and collider and spawner then
        Sunshine:update(function()
            if collider.hitEntity and collider.hitEntity.character and collider.hitEntity.character.controllable then
                spawner.active = true
            end
        end, entity)
    end
end