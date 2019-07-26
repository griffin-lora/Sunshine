local StarterGui = game:GetService("StarterGui")

return function(_, enabled)
    StarterGui:SetCore("TopbarEnabled", enabled)
end