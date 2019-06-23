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