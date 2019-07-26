-- TrafficConeGod

return function(Sunshine, entity, scene)
    local transform = entity.transform
    local spinner = entity.spinner
    if transform and spinner then
        Sunshine:update(function()
            if spinner.speed ~= 0 then
                local angle = (Sunshine:tick(scene) % math.pi) * spinner.speed
                if spinner.axis == "x" then
                    transform.cFrame = CFrame.new(transform.cFrame.Position) * CFrame.Angles(angle, 0, 0)
                elseif spinner.axis == "y" then
                    transform.cFrame = CFrame.new(transform.cFrame.Position) * CFrame.Angles(0, angle, 0)
                elseif spinner.axis == "z" then
                    transform.cFrame = CFrame.new(transform.cFrame.Position) * CFrame.Angles(0, 0, angle)
                elseif spinner.axis == "xyz" then
                    transform.cFrame = CFrame.new(transform.cFrame.Position) * CFrame.Angles(angle, angle, angle)
                end
            end
        end, entity)
    end
end