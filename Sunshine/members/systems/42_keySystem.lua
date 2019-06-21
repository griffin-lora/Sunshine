return function(Sunshine, entity)
    local key = entity.key
    local collider = entity.collider
    local spawner = entity.spawner
    Sunshine:update(function()
        if collider.hitEntity and collider.hitEntity.character and collider.hitEntity.character.controllable then
            spawner.active = true
        end
    end, entity)
end