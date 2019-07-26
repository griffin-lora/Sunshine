return function(Sunshine, systemFolder)
    for _, systemModule in pairs(systemFolder:GetChildren()) do
        local split = systemModule.Name:split("_")
        local index = tonumber(split[1])
        Sunshine.systems[index] = require(systemModule)
    end
end