return function(Sunshine, entity)
    local collectible = entity.collectible
    local transform = entity.transform
    local collider = entity.collider
    if collectible and transform and collider then
        local collected = false
        Sunshine:update(function(step)
            if collected and transform.size.Magnitude > 0.05 then
                transform.size = transform.size:Lerp(Vector3.new(0, 0, 0), step * collectible.speed)
            elseif collected then
                transform.size = Vector3.new(0, 0, 0)
            elseif collider.hitEntity and collider.hitEntity.tag and collider.hitEntity.tag.tag == "character" then
                collected = true
            end
        end)
    end
end