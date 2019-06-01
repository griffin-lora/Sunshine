-- SuperMakerPlayer and TrafficConeGod

local SoundService = game:GetService("SoundService")

return function(Sunshine, entity)
    local sound = entity.sound
	if sound then
		local lastId = sound.id
		if sound.onStart then
	        local soundInstance = Instance.new("Sound")
	        soundInstance.SoundId = "rbxassetid://"..sound.id
			soundInstance.Looped = sound.looped
	        soundInstance.Parent = SoundService
	        soundInstance:Play()
		end
        Sunshine:update(function()
           	for _,p in pairs(game.SoundService:GetChildren()) do
				if p:IsA("Sound") then
					if not p.Playing then
						p:Destroy()
					end
				end
			end
            if sound.id ~= lastId then
                if sound.id then
                    local soundInstance = Instance.new("Sound")
                    soundInstance.SoundId = "rbxassetid://"..sound.id
					soundInstance.Looped = sound.looped
                    soundInstance.Parent = SoundService
                    soundInstance:Play()
                end
            end
			lastId = sound.id
		end)
	end
end