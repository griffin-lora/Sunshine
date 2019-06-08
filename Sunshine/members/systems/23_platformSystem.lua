local moveTo = "destination"

return function(Sunshine, entity)
    local transform = entity.transform
    local moving = entity.moving

    if transform and moving then
        if moving.speed ~= 0 then
            local start = transform.cFrame
            local destination = transform.cFrame * moving.extend
            Sunshine:update(function(step)
                if transform.cFrame == start and moveTo == "start" then
                    moveTo = "destination"
                elseif transform.cFrame == destination and moveTo == "destination" then
                    moveTo = "start"
                end
                
                if moveTo == "destination" then
                    transform.cFrame = transform.cFrame:Lerp(destination, step * moving.speed)
                elseif moveTo == "start" then
                    transform.cFrame = transform.cFrame:Lerp(start, step * moving.speed)
                end
            end)
        end
    end
end