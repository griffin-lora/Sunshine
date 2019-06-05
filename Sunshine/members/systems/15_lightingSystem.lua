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
		Lighting.Brightness = lighting.lightness
		Lighting.GlobalShadows = lighting.globalShadows
		Lighting.ClockTime = lighting.clockTime
		Lighting.GeographicLatitude = lighting.sunPos
		Lighting.FogColor = lighting.fogColor
		Lighting.FogStart = lighting.fogStart
		Lighting.FogEnd = lighting.fogEnd
		local color = Instance.new("ColorCorrectionEffect")
		Sunshine:addInstance(color)
		local blur = Instance.new("BlurEffect")
		Sunshine:addInstance(blur)
		local bloom = Instance.new("BloomEffect")
		Sunshine:addInstance(bloom)
		local rays = Instance.new("SunRaysEffect")
		Sunshine:addInstance(rays)
		color.Brightness = color.brightness
		color.Contrast = color.contrast
		color.Saturation = color.saturation
		color.TintColor = color.tintColor
		blur.Size = color.blurAmount
		bloom.Threshold = color.bloomThreshold
		rays.Enabled = color.sunRays
	end
end