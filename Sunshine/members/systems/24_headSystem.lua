return function(Sunshine, entity, scene)
    local head = entity.head
    local transform = entity.transform
    local collider = entity.collider
    if head and collider then
        local bounceTick
        local startTick = Sunshine:tick(scene)
        local active = true
        local canBounce = true
        local first = true
        Sunshine:update(function(step)
            local character = Sunshine:getEntity(head.character, scene)
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
                        if (Sunshine:tick(scene) - startTick) > head.holdTime then
                            active = false
                        end
                    elseif (Sunshine:tick(scene) - startTick) > head.time then
                        active = false
                    end
                else
                    if (Sunshine:tick(scene) - bounceTick) > head.bounceTime then
                        active = false
                    end
                end
                if active and canBounce and collider.hitEntity == character and character.bounce.bounceCount < 1 then
                    canBounce = false
                    collider.trigger = false
                    bounceTick = Sunshine:tick(scene)
                    if not character.character.swimming then
                        character.character.state = "bounce"
                    end
                elseif active and collider.hitEntity and collider.hitEntity.capture then
                    active = false
                    local player = character.character.player
                    player.player.character = collider.hitEntity
                    collider.hitEntity.respawner.active = false
                    Sunshine:destroyEntity(entity)
                elseif active and collider.hitEntity and collider.trigger and collider.hitEntity.crate and
                collider.hitEntity.transparency and collider.hitEntity.physics then
                    if collider.hitEntity.crate.hits > 0 then
                        print("lol die")
                        collider.trigger = false
                        collider.hitEntity.crate.hits = collider.hitEntity.crate.hits - 1
                        if collider.hitEntity.crate.hits == 0 then
                            print("ded (swear word)")
                            collider.hitEntity.physics.canCollide = false
                            collider.hitEntity.transparency.transparency = 1
                            if collider.hitEntity.spawner.entity then
                                collider.hitEntity.spawner.active = true
                                print("spawn")
                            end
                        end
                    end
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