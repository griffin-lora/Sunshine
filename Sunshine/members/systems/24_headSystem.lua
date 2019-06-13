return function(Sunshine, entity)
    local head = entity.head
    local transform = entity.transform
    local collider = entity.collider
    if head and collider then
        transform.cFrame = head.cFrame
        local bounceTick
        local startTick = tick()
        local active = true
        Sunshine:update(function()
            local character = Sunshine:getEntityById(head.character)
            if active then
                if (tick() - startTick) > 2 then
                    Sunshine:destroyEntity(entity)
                elseif collider.hitEntity == character then
                    active = false
                    bounceTick = tick()
                    character.character.state = nil
                    collider.trigger = false
                end
            else
                if (tick() - bounceTick) > 2 then
                    Sunshine:destroyEntity(entity)
                end
            end
        end, entity)
    end
end