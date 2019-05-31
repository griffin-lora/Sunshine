-- TrafficConeGod

return function(Sunshine, entity)
    local transform = entity.transform
    local spinner = entity.spinner
    if transform and spinner then
        Sunshine:update(function()
            transform.cFrame = CFrame.new(transform.cFrame.Position) * CFrame.Angles(0, (tick() % math.pi) * spinner.speed, 0)
        end)
    end
end