return function(Sunshine, entity)
    local musicTracker = entity.musicTracker
    local sound = entity.sound

    if musicTracker and sound then
        Sunshine:update(function()
            if Sunshine.scenes[1] then
                local music = Sunshine:getEntity(musicTracker.entity, Sunshine.scenes[1])
                if music then
                    sound.id = music.music.id
                    sound.volume = music.music.volume
                    if Sunshine.scenes[1].active == true then
                        sound.playing = not music.music.paused
                    else
                        sound.playing = false
                    end
                else
                    sound.playing = false
                end
            else
                sound.playing = false
            end
        end, entity)
    end
end