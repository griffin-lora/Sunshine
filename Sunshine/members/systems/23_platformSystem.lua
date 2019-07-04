
return function(Sunshine, entity)
    local transform = entity.transform
    local moving = entity.moving
    local physics = entity.physics
    local moveTo = "destination"

    if transform and moving then
        local lastLerp = transform.cFrame
        if moving.speed ~= 0 then
            local start = transform.cFrame
            local destination = transform.cFrame * moving.extend
            Sunshine:update(function(step)
                if (transform.cFrame.Position - start.Position).Magnitude < 1 and moveTo == "start" then
                    moveTo = "destination"
                elseif (transform.cFrame.Position - destination.Position).Magnitude < 1 and moveTo == "destination" then
                    moveTo = "start"
                end
                if moveTo == "destination" then
                    local lerp = transform.cFrame:Lerp(destination, step * moving.speed)
                    transform.cFrame = lerp
                    physics.velocity = physics.velocity + (lerp.Position - lastLerp.Position)
                    lastLerp = transform.cFrame
                elseif moveTo == "start" then
                    local lerp = transform.cFrame:Lerp(start, step * moving.speed)
                    transform.cFrame = lerp
                    physics.velocity = physics.velocity + (lerp.Position - lastLerp.Position)
                    lastLerp = transform.cFrame
                end
            end)
        end
    end
end