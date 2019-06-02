return function(Sunshine, entity)
	
	local lighting = entity.lighting
	
	if lighting then
		local sky = lighting.sky:Clone()
		sky.Parent = game.Lighting
		Sunshine:addInstance(sky)
		game.Lighting.Ambient = lighting.ambient
		game.Lighting.OutdoorAmbient = lighting.outdoorAmbient
		game.Lighting.Brightness = lighting.brightness
		game.Lighting.GlobalShadows = lighting.globalShadows
		game.Lighting.ClockTime = lighting.clockTime
		game.Lighting.FogColor = lighting.fogColor
		game.Lighting.FogStart = lighting.fogStart
		game.Lighting.FogEnd = lighting.fogEnd
	end
end