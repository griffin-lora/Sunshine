local RunService = game:GetService("RunService")

return function(Sunshine, callback)
    Sunshine:addConnection(RunService.RenderStepped, callback) 
end