-- SuperMakerPlayer and TrafficConeGod

return function(Sunshine, entity)
	local coin = entity.coin
    local transform = entity.transform
    local collider = entity.collider
    local transparency = entity.transparency
    local sound = entity.sound

    local stop = false

    if coin and transform and collider and sound and transparency then
        local collected = false
        local info = coin.tweenInfo
        local startTick
        local size = transform.size
        Sunshine:update(function(step)
            if collected and tick() - startTick <= info.Time then
                transform.size = Sunshine:tween(tick() - startTick, info, size, Vector3.new(0, 0, 0))
            elseif collected then
                transform.size = Vector3.new(0, 0, 0)
                transparency.transparency = 1
            end

            local entity = collider.hitEntity
            if entity and entity.character and entity.character.player and not collected then
                local player = entity.character.player
                collected = true
                player.stats.coins = player.stats.coins + 1
                sound.playing = true
                stop = true
                startTick = tick()
            end

            if startTick ~= nil and stop then
                if tick() - startTick > 0.6 then
                    sound.playing = false
                    stop = false
                end
            end
        end, entity)
    end
end