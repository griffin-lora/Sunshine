local VECTOR3_NEW = Vector3.new
local VECTOR2_NEW = Vector2.new

local enums = {
    [Enum.EasingStyle.Linear] = "linear",
    [Enum.EasingStyle.Quad] = "quadratic",
    [Enum.EasingStyle.Quart] = "quartic",
    [Enum.EasingStyle.Quint] = "quintic",
    [Enum.EasingStyle.Sine] = "sinusoidal",
    [Enum.EasingStyle.Elastic] = "elastic",
    [Enum.EasingStyle.Back] = "back",
    [Enum.EasingStyle.Bounce] = "bounce",
}

return function(Sunshine, time, info, start, goal)
    local type = typeof(start)
    if type ~= "number" then
        if type == "Vector2" then
            return VECTOR2_NEW(Sunshine:tween(time, info, start.X, goal.X), Sunshine:tween(time, info, start.Y, goal.Y))
        elseif type == "Vector3" then
            return VECTOR3_NEW(Sunshine:tween(time, info, start.X, goal.X), Sunshine:tween(time, info, start.Y, goal.Y),
            Sunshine:tween(time, info, start.Z, goal.Z))
        elseif type == "UDim2" then
            return UDim2.new(Sunshine:tween(time, info, start.X.Scale, goal.X.Scale),
            Sunshine:tween(time, info, start.X.Offset, goal.X.Offset),
            Sunshine:tween(time, info, start.Y.Scale, goal.Y.Scale),
            Sunshine:tween(time, info, start.Y.Offset, goal.Y.Offset))
        else
            error("Type " .. type .. " is unsupported for tweening")
        end
    else
        time = math.clamp(time, 0, info.Time)
        local elapsed = time / info.Time
        local easing = Sunshine.easing[enums[info.EasingStyle]]
        local alpha
        if info.EasingDirection == Enum.EasingDirection.In then
            alpha = easing.easeIn(elapsed)
        elseif info.EasingDirection == Enum.EasingDirection.Out then
            alpha = easing.easeOut(elapsed)
        else
            alpha = easing.easeInOut(elapsed)
        end
        local value = Sunshine:lerp(start, goal, alpha)
        return value
    end
end