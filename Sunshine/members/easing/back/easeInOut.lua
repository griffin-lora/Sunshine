return function(k)
    local s = 1.70158 * 1.525
    if (k ^ 2) < 1 then
        return 0.5 * (k * k * ((s + 1) * k - s))
    end
    return 0.5 * ((k - 2) * k * ((s + 1) * k + s) + 2)
end