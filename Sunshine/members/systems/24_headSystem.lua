return function(Sunshine, entity)
    local head = entity.head
    local transform = entity.transform
    local collider = entity.collider
    if head and collider then
        local bounceTick
        local startTick = tick()
        local active = true
        local first = true
        Sunshine:update(function(step)
            local character = Sunshine:getEntityById(head.character)
            if active then
                if first then
                    transform.cFrame = character.transform.cFrame
                    first = false
                end
                transform.cFrame = transform.cFrame:Lerp(head.cFrame, step * 10)
                if (transform.cFrame.Position - character.transform.cFrame.Position).Magnitude > 2 then
                    collider.trigger = true
                end
                if character.input.e then
                    if (tick() - startTick) > head.holdTime then
                        active = false
                        Sunshine:destroyEntity(entity)
                    end
                elseif (tick() - startTick) > head.time then
                    active = false
                    Sunshine:destroyEntity(entity)
                end
                if active and collider.hitEntity == character then
                    active = false
                    bounceTick = tick()
                    character.character.state = "bounce"
                    collider.trigger = false
                elseif active and collider.hitEntity and collider.hitEntity.capture then
                    active = false
                    character.character.controllable = false
                    collider.hitEntity.character.controllable = true
                    collider.hitEntity.capture.character = character.core.id
                    collider.hitEntity.capture.active = true
                    Sunshine:destroyEntity(entity)
                end
            else
                if (tick() - bounceTick) > head.bounceTime then
                    Sunshine:destroyEntity(entity)
                end
            end
        end, entity)
    end
end