return function(Sunshine, entity)
    local head = entity.head
    local transform = entity.transform
    local collider = entity.collider
    if head and collider then
        local bounceTick
        local startTick = entity.core.tick
        local active = true
        local canBounce = true
        local first = true
        Sunshine:update(function(step)
            local character = Sunshine:getEntity(head.character, entity.core.scene)
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
                        if (entity.core.tick - startTick) > head.holdTime then
                            active = false
                        end
                    elseif (entity.core.tick - startTick) > head.time then
                        active = false
                    end
                else
                    if (entity.core.tick - bounceTick) > head.bounceTime then
                        active = false
                    end
                end
                for _, hitEntity in pairs(collider.hitEntities) do
                    if active and canBounce and hitEntity == character and character.bounce.bounceCount < 1 then
                        canBounce = false
                        collider.trigger = false
                        bounceTick = entity.core.tick
                        if not character.character.swimming then
                            character.character.state = "bounce"
                        end
                    elseif active and hitEntity and hitEntity.capture then
                        active = false
                        local player = character.character.player
                        player.player.character = hitEntity
                        Sunshine:destroyEntity(entity)
                    end
                end
            else
                transform.cFrame = transform.cFrame:Lerp(character.transform.cFrame, step * 15)
                if (transform.cFrame.Position - character.transform.cFrame.Position).Magnitude < 5 then
                    Sunshine:destroyEntity(entity)
                end
            end
        end, entity)
    end
end