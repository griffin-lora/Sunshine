-- TrafficConeGod

return function(Sunshine, entity, scene)
    local transform = entity.transform
    local oscillator = entity.oscillator
    if transform and oscillator then
        local cFrame = transform.cFrame
        Sunshine:update(function()
            local offset = math.sin(entity.core.tick * oscillator.frequency) * oscillator.amplitude
            if oscillator.axis == "x" then
                transform.cFrame = cFrame + Vector3.new(offset, 0, 0)
            elseif oscillator.axis == "y" then
                transform.cFrame = cFrame + Vector3.new(0, offset, 0)
            elseif oscillator.axis == "z" then
                transform.cFrame = cFrame + Vector3.new(0, 0, offset)
            end
        end, entity)
    end
end