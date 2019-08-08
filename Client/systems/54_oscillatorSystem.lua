-- TrafficConeGod

local VECTOR3_NEW = Vector3.new

return function(Sunshine, entity)
    local transform = entity.transform
    local oscillator = entity.oscillator
    if transform and oscillator then
        local cFrame = transform.cFrame
        Sunshine:update(function()
            local offset = math.sin(entity.core.tick * oscillator.frequency) * oscillator.amplitude
            if oscillator.axis == "x" then
                transform.cFrame = cFrame + VECTOR3_NEW(offset, 0, 0)
            elseif oscillator.axis == "y" then
                transform.cFrame = cFrame + VECTOR3_NEW(0, offset, 0)
            elseif oscillator.axis == "z" then
                transform.cFrame = cFrame + VECTOR3_NEW(0, 0, offset)
            end
        end, entity)
    end
end