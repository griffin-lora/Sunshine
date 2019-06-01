return function(Sunshine)
    if Sunshine.scene then
        Sunshine.updateCallbacks = {}
        for _, connection in pairs(Sunshine.connections) do
            connection:Disconnect()
        end
        for _, instance in pairs(Sunshine.instances) do
            instance:Destroy()
        end
		game.ReplicatedStorage.Assets.skies.BrightBlue:Clone().Parent = game.Lighting
		game.Lighting.Brightness = 2
		game.Lighting.GlobalShadows = true
		game.Lighting.ClockTime = 12
		game.Lighting.FogStart = 0
		game.Lighting.FogEnd = 100000
        Sunshine.dataScene = nil
        Sunshine.scene = nil
    end
end