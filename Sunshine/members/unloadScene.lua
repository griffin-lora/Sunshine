return function(Sunshine)
    if Sunshine.scene then
        Sunshine.updateCallbacks = {}
        for _, connection in pairs(Sunshine.connections) do
            connection:Disconnect()
        end
        for _, instance in pairs(Sunshine.instances) do
            instance:Destroy()
        end
        local sky = game.ReplicatedStorage.Assets.skies.BrightBlue:Clone()
        sky.Parent = game.Lighting
        Sunshine:addInstance(sky)
		game.Lighting.Brightness = 2
		game.Lighting.GlobalShadows = true
		game.Lighting.ClockTime = 12
		game.Lighting.FogStart = 0
		game.Lighting.FogEnd = 100000
        Sunshine.dataScene = nil
        Sunshine.scene = nil
    end
end