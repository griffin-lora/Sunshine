-- TrafficConeGod

local CFRAME_NEW = CFrame.new

return function(Sunshine, entity)
    local transform = entity.transform
    local spinner = entity.spinner
    if transform and spinner then
        Sunshine:update(function()
            local pos = transform.cFrame.Position
            local preCalcCFrame = CFRAME_NEW(pos)
            if spinner.speed ~= 0 then
                local angle = (entity.core.tick * spinner.speed) % (math.pi * 2)
                if spinner.axis == "x" then
                    transform.cFrame = preCalcCFrame * CFrame.Angles(angle, 0, 0)
                elseif spinner.axis == "y" then
                    transform.cFrame = preCalcCFrame * CFrame.Angles(0, angle, 0)
                elseif spinner.axis == "z" then
                    transform.cFrame = preCalcCFrame * CFrame.Angles(0, 0, angle)
                end
            end
        end, entity)
    end
end