return function(Sunshine)
    if Sunshine.scene then
        for _, connection in pairs(Sunshine.connections) do
            connection:Disconnect()
        end
        for _, instance in pairs(Sunshine.instances) do
            instance:Destroy()
        end
        Sunshine.scene = nil
    end
end