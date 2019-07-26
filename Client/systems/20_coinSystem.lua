-- SuperMakerPlayer and TrafficConeGod

return function(Sunshine, entity)
	local coin = entity.coin
    local transform = entity.transform
    local collider = entity.collider
    local sound = entity.sound

    local stop = false

    if coin and transform and collider and sound then
        local collected = false
        local info = coin.tweenInfo
        local startTick
        local size = transform.size
        Sunshine:update(function()
            if collected and entity.core.tick - startTick <= info.Time then
                transform.size = Sunshine:tween(entity.core.tick - startTick, info, size, Vector3.new(0, 0, 0))
            elseif collected then
                Sunshine:destroyEntity(entity)
            end
            local hitEntity = collider.hitEntity
            if hitEntity and hitEntity.character and hitEntity.character.player and not collected then
                local player = hitEntity.character.player
                collected = true
                player.stats.coins = player.stats.coins + 1
                sound.playing = true
                stop = true
                startTick = entity.core.tick
            end
            if startTick ~= nil and stop then
                if entity.core.tick - startTick > 0.6 then
                    sound.playing = false
                    stop = false
                end
            end
        end, entity)
    end
end