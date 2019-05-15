return function(Sunshine, event, callback)
    Sunshine.connections[#Sunshine.connections + 1] = event:Connect(function(...)
        if not Sunshine.paused then
            callback(...)
        end
    end)
end