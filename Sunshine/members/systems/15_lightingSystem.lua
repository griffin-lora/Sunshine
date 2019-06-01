return function(Sunshine, entity)
	
	local lighting = entity.lighting
	
	for _,p in pairs(game.Lighting:GetChildren()) do
		if p:IsA("Sky") then
			p:Destroy()
		end
	end
	
	if lighting then
		
		lighting.sky:Clone().Parent = game.Lighting
		game.Lighting.Brightness = lighting.brightness
		
		game.Lighting.GlobalShadows = lighting.globalShadows
		game.Lighting.ClockTime = lighting.clockTime
		
		game.Lighting.FogStart = lighting.fogStart
		game.Lighting.FogEnd = lighting.fogEnd
		
	else
		
		game.ReplicatedStorage.Assets.skies.BrightBlue:Clone().Parent = game.Lighting
		game.Lighting.Brightness = 2
		
		
		game.Lighting.GlobalShadows = true
		game.Lighting.ClockTime = 12
		
		game.Lighting.FogStart = 0
		game.Lighting.FogEnd = 100000
		
	end
end