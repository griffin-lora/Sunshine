-- SuperMakerPlayer and TrafficConeGod

return function(Sunshine, entity)
	local coin = entity.coin
    local transform = entity.transform
    local collider = entity.collider
    local transparency = entity.transparency
    local sound = entity.sound

    local stop = false
    local timeSince = nil

    if coin and transform and collider and sound and transparency then
        local collected = false
        Sunshine:update(function(step)
            if collected and transform.size.Magnitude > 0.001 then
                transform.size = transform.size:Lerp(Vector3.new(0, 0, 0), step * 12)
            elseif collected then
                transform.size = Vector3.new(0, 0, 0)
                transparency.transparency = 1
            end

            local entity = collider.hitEntity
            if entity and entity.stats and not collected then
                collected = true
                entity.stats.coins = entity.stats.coins + 1
                sound.playing = true
                stop = true
                timeSince = tick()
            end

            if timeSince ~= nil and stop then
                if tick() - timeSince > 0.6 then
                    sound.playing = false
                    stop = false
                end
            end
        end, entity)
    end
end