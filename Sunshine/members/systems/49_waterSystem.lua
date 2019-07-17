return function(Sunshine, entity)
    local water = entity.water
    local collider = entity.collider
    if water and collider then
        local character
        Sunshine:update(function()
            if collider.hitEntity and collider.hitEntity.hydrophobic and collider.hitEntity.health then
                collider.hitEntity.health.health = 0
            elseif collider.hitEntity and collider.hitEntity.character and collider.hitEntity.character.controllable
            then
                character = collider.hitEntity
                character.character.swimming = true
            elseif character then
                character.character.swimming = false
            end
        end, entity)
    end
end