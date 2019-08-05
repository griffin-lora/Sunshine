-- SuperMakerPlayer

local Lighting = game:GetService("Lighting")

return function(Sunshine, entity)
	local lighting = entity.lighting
	local lastTintColor = Color3.fromRGB(255,255,255)
    if lighting then
        if lighting.sky then
            local sky = lighting.sky:Clone()
            sky.Parent = Lighting
            Sunshine:addInstance(sky, entity)
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
		Sunshine:addInstance(color, entity)
		local blur = Instance.new("BlurEffect")
		Sunshine:addInstance(blur, entity)
		local bloom = Instance.new("BloomEffect")
		Sunshine:addInstance(bloom, entity)
		local rays = Instance.new("SunRaysEffect")
		Sunshine:addInstance(rays, entity)
		color.Brightness = lighting.brightness
		color.Contrast = lighting.contrast
		color.Saturation = lighting.saturation
		color.TintColor = lighting.tintColor
		lastTintColor = lighting.tintColor
		blur.Size = lighting.blurAmount
		bloom.Threshold = lighting.bloomThreshold
		rays.Enabled = lighting.sunRays
		rays.Intensity = lighting.sunIntensity
		color.Parent = game.Lighting
		blur.Parent = game.Lighting
		bloom.Parent = game.Lighting
		rays.Parent = game.Lighting
		Sunshine:update(function()
			if lighting.tintColor ~= lastTintColor then
				color.tintColor = lighting.tintColor
				lastTintColor = lighting.tintColor
			end
			
		end, entity)
	end
end