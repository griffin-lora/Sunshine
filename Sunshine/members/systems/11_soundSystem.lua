-- SuperMakerPlayer and TrafficConeGod

local SoundService = game:GetService("SoundService")

return function(Sunshine, entity)
    local sound = entity.sound
	if sound then
		local lastId = sound.id
        Sunshine:update(function()
            local soundInstance
            if sound.id ~= lastId then
                if soundInstance then
                    soundInstance:Destroy()
                end
                if sound.id then
                    soundInstance = Instance.new("Sound")
                    soundInstance.SoundId = "rbxassetid://"..sound.id
                    soundInstance.Parent = SoundService
                    soundInstance:Play()
                end
            end
			lastId = sound.id
		end)
	end
end