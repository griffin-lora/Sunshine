return function(Sunshine, entity, scene)
    local fade = entity.fade
    local transparency = entity.transparency
    local completed = false

    if fade and transparency then
        Sunshine:update(function()
            if not completed then
                if fade.direction == "out" then
                    transparency.transparency = transparency.transparency + fade.increment
                else
                    transparency.transparency = transparency.transparency - fade.increment
                end
                if transparency.transparency >= 1 and fade.direction == "out" then
                    completed = true
                elseif transparency.transparency <= 0 and fade.direction ~= "out" then
                    completed = true
                end
            end
        end, entity)
    end
end