--YAYAYAYAYAYAYAYAYAYAYAYAYAYAYAYAYAYAYAYAYAYAYAYAYAYAYAYAYAYAYAYAYA

local SoundService = game:GetService("SoundService")

local INSTANCE_NEW = Instance.new

return function(Sunshine, entity)
    local speaker = entity.speaker
    if speaker then
        local soundInstances = {}
        Sunshine:update(function()
            if speaker.playing then
                local soundInstance = INSTANCE_NEW("Sound")
                soundInstance.SoundId = "rbxassetid://"..speaker.id
                soundInstance.Volume = speaker.volume
                soundInstance.Playing = true
                soundInstance.Parent = SoundService
                local index = #soundInstances + 1
                soundInstances[index] = soundInstance
                speaker.playing = false
                Sunshine:addConnection(soundInstance.Ended, function()
                    soundInstance:Destroy()
                    soundInstances[index] = nil
                end, entity)
            end
            speaker.sounds = #soundInstances
            for _, soundInstance in pairs(soundInstances) do
                soundInstance.Playing = entity.core.active and entity.core.scene.active
            end
        end, entity, true)
    end
end