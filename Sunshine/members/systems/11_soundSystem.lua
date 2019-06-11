-- SuperMakerPlayer and TrafficConeGod

local SoundService = game:GetService("SoundService")

return function(Sunshine, entity)
    local sound = entity.sound
	if sound then
        local lastId
        local soundInstance
        Sunshine:update(function()
            if sound.id ~= lastId then
                if sound.id then
                    if soundInstance then
                        soundInstance:Destroy()
                    end
                    soundInstance = Instance.new("Sound")
                    soundInstance.SoundId = "rbxassetid://"..sound.id
					soundInstance.Parent = SoundService
					Sunshine:addInstance(soundInstance)
                end
            end
            if soundInstance then
                soundInstance.Playing = sound.playing
                soundInstance.Looped = sound.looped
                soundInstance.Volume = sound.volume
            end
			lastId = sound.id
		end)
	end
end