local state = "groundPound"

return function(Sunshine, entity)
    local component = entity[state]
    local character = entity.character
    local input = entity.input
    local transform = entity.transform
    local physics = entity.physics
    local animator = entity.animator
    if component and character and input and transform and physics and animator then
        local lastState = character.state
        local startTick
        Sunshine:update(function()
            if character.controllable then
                if character.state == state then
                    -- update
                    if (tick() - startTick) > component.delay then
                        physics.movable = true
                        physics.velocity = Vector3.new(0, component.speed, 0)
                        if animator.action ~= 1146924615 then
                            animator.action = 1146924615
                        end
                    else
                        physics.movable = false
                    end
                    if character.grounded or (lastState == state and character.state ~= state) then
                        -- end
                        physics.velocity = Vector3.new(0, 0, 0)
                        physics.movable = true
                        animator.action = nil
                        character.state = nil
                    end
                elseif character.state ~= "dive" and not character.grounded and input.shift or (lastState ~= state and character.state == state) then
                    -- start
                    character.state = state
                    physics.movable = false
                    startTick = tick()
                    animator.action = 1146925487
                end
            end
            lastState = character.state
        end)
    end
end