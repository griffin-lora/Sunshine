return function(_, start, goal, alpha)
    return start * (1 - alpha) + (goal * alpha)
end