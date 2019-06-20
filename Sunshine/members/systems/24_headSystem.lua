return function(Sunshine, entity)
    local head = entity.head
    local transform = entity.transform
    local collider = entity.collider
    if head and collider then
        local bounceTick
        local startTick = tick()
        local active = true
        local canBounce = true
        local first = true
        Sunshine:update(function(step)
            local character = Sunshine:getEntity(head.character)
            if head.cFrame and active then
                if first then
                    transform.cFrame = character.transform.cFrame
                    first = false
                end
                transform.cFrame = transform.cFrame:Lerp(head.cFrame, step * 10)
                if (transform.cFrame.Position - character.transform.cFrame.Position).Magnitude > 2 then
                    collider.trigger = true
                end
                if collider.trigger then
                    if character.input.e or character.character.state == "dive" then
                        if (tick() - startTick) > head.holdTime then
                            active = false
                        end
                    elseif (tick() - startTick) > head.time then
                        active = false
                    end
                else
                    if (tick() - bounceTick) > head.bounceTime then
                        active = false
                    end
                end
                if active and canBounce and collider.hitEntity == character and character.bounce.bounceCount < 1 then
                    canBounce = false
                    collider.trigger = false
                    bounceTick = tick()
                    character.character.state = "bounce"
                elseif active and collider.hitEntity and collider.hitEntity.capture then
                    active = false
                    local player = character.character.player
                    player.player.character = collider.hitEntity
                    Sunshine:destroyEntity(entity)
                end
            else
                transform.cFrame = transform.cFrame:Lerp(character.transform.cFrame, step * 10)
                if (transform.cFrame.Position - character.transform.cFrame.Position).Magnitude < 5 then
                    Sunshine:destroyEntity(entity)
                end
            end
        end, entity)
    end
end