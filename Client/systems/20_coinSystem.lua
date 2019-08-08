-- SuperMakerPlayer and TrafficConeGod

local ZERO_VECTOR3 = Vector3.new(0,0,0)

return function(Sunshine, entity)
    local coin = entity.coin
    local regionalCoin = entity.regionalCoin
    local transform = entity.transform
    local collider = entity.collider
    local speaker = entity.speaker

    local stop = false

    if (coin or regionalCoin) and transform and collider and speaker then
        local collected = false
        local info
        if coin then
            info = coin.tweenInfo
        elseif regionalCoin then
            info = regionalCoin.tweenInfo
        end
        local startTick
        local size = transform.size
        Sunshine:update(function()
            if collected and entity.core.tick - startTick <= info.Time then
                transform.size = Sunshine:tween(entity.core.tick - startTick, info, size, ZERO_VECTOR3)
            elseif collected and speaker.sounds == 0 then
                Sunshine:destroyEntity(entity)
            end
            for _, hitEntity in pairs(collider.hitEntities) do
                if hitEntity and ((hitEntity.head and hitEntity.head.character) or (hitEntity.character and
                hitEntity.character.player)) and not collected then
                    local player
                    if hitEntity.character then
                        player = Sunshine:getEntity(hitEntity.character.player, entity.core.scene)
                    elseif hitEntity.head then
                        local character = Sunshine:getEntity(hitEntity.head.character, entity.core.scene)
                        player = Sunshine:getEntity(character.character.player, entity.core.scene)
                    end
                    startTick = entity.core.tick
                    collected = true
                    if coin then
                        player.stats.coins = player.stats.coins + 1
                    elseif regionalCoin then
                        player.stats.regionalCoins = player.stats.regionalCoins + 1
                    end
                    speaker.playing = true
                    stop = true
                end
                if startTick ~= nil and stop then
                    if entity.core.tick - startTick > 0.6 then
                        stop = false
                    end
                end
            end
        end, entity)
    end
end