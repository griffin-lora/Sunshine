--YAYAYAYAYAYAYAYAYAYAYAYAYAYAYAYAYAYAYAYAYAYAYAYAYAYAYAYAYAYAYAYAYA

local SoundService = game:GetService("SoundService") 

return function(Sunshine, entity)
    local speaker = entity.speaker 
    if speaker then
        Sunshine:update(function()
            if speaker.playing then
                local soundInstance = Instance.new("Sound")
                soundInstance.SoundId = "rbxassetid://"..speaker.id
                soundInstance.Volume = speaker.volume
                soundInstance.Playing = true
                soundInstance.Parent = SoundService
                speaker.playing = false
                Sunshine:addConnection(soundInstance.Paused, function()
                
                end, entity)
            end
        end, entity)
    end
end