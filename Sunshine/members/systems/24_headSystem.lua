return function(Sunshine, entity)
    local head = entity.head
    local transform = entity.transform
    local collider = entity.collider
    if head and collider then
        transform.cFrame = head.cFrame
        Sunshine:update(function()
            local character = Sunshine:getEntityById(head.character)
            if collider.hitEntity == character then
                collider.trigger = false
            end
        end)
    end
end