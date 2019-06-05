-- SuperMakerPlayer

local Lighting = game:GetService("Lighting")

return function(Sunshine, entity)
	local lighting = entity.lighting
    if lighting then
        if lighting.sky then
            local sky = lighting.sky:Clone()
            sky.Parent = Lighting
            Sunshine:addInstance(sky)
        end
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
		color.Brightness = lighting.brightness
		color.Contrast = lighting.contrast
		color.Saturation = lighting.saturation
		color.TintColor = lighting.tintColor
		blur.Size = lighting.blurAmount
		bloom.Threshold = lighting.bloomThreshold
		rays.Enabled = lighting.sunRays
		color.Parent = game.Lighting
		blur.Parent = game.Lighting
		bloom.Parent = game.Lighting
		rays.Parent = game.Lighting
	end
end