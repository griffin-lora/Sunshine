-- SuperMakerPlayer

local Lighting = game:GetService("Lighting")

return function(Sunshine, entity)
	local lighting = entity.lighting
	if lighting then
		local sky = lighting.sky:Clone()
		sky.Parent = Lighting
		Sunshine:addInstance(sky)
		Lighting.Ambient = lighting.ambient
		Lighting.OutdoorAmbient = lighting.outdoorAmbient
		Lighting.Brightness = lighting.brightness
		Lighting.GlobalShadows = lighting.globalShadows
		Lighting.ClockTime = lighting.clockTime
		Lighting.FogColor = lighting.fogColor
		Lighting.FogStart = lighting.fogStart
		Lighting.FogEnd = lighting.fogEnd
	end
end