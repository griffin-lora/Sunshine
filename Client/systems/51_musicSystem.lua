return function(Sunshine, entity)
    local musicTracker = entity.musicTracker
    local sound = entity.sound
    local lowVolume
    local unloadStartTick
    local loadStartTick
    local lastUnload
    local lastLoad
    local oldVolume = 0

    if musicTracker and sound then
        Sunshine:update(function()
            if Sunshine.scenes[1] then
                lastUnload = false
                local music = Sunshine:getEntity(musicTracker.entity, Sunshine.scenes[1])
                if music then
                    if not lastLoad then
                        loadStartTick = entity.core.tick
                    end
                    lastLoad = true
                    sound.id = music.music.id
                    sound.volume = Sunshine:tween(entity.core.tick - loadStartTick, TweenInfo.new(0.5, Enum.EasingStyle.Sine, Enum.EasingDirection.In, 0, false, 0), oldVolume, music.music.volume)
                    lowVolume = music.music.volume/2
                    if Sunshine.scenes[1].active == true then
                        sound.playing = not music.music.paused
                    else
                        sound.playing = false
                    end
                else
                    sound.playing = false
                end
            else
                if not lastUnload then
                    unloadStartTick = entity.core.tick
                end
                lastUnload = true
                sound.volume = Sunshine:tween(entity.core.tick - unloadStartTick, TweenInfo.new(0.5, Enum.EasingStyle.Sine, Enum.EasingDirection.Out, 0, false, 0), lowVolume*2, lowVolume)
                oldVolume = sound.volume
            end
        end, entity)
    end
end