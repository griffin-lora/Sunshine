return function(Sunshine, entity)
    local head = entity.head
    local transform = entity.transform
    local collider = entity.collider
    if head and collider then
        transform.cFrame = head.cFrame
        Sunshine:update(function()
            if collider.hitEntity and collider.hitEntity.tag and collider.hitEntity.tag.tag == "character" then
                transform.cFrame = collider.hitEntity.transform.cFrame
            end
        end)
    end
end