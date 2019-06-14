-- SuperMakerPlayer and TrafficConeGod

local plr = game.Players.LocalPlayer
local addCoin = false
local addScript = false
local last = 0
local timeSinceLast = nil
local removeScript = false

return function(Sunshine, entity)
	local coin = entity.coin
    local transform = entity.transform
    local collider = entity.collider
    local sound = entity.sound
    if coin and transform and collider and sound then
        local collected = false
        Sunshine:update(function(step)
            if collected and transform.size.Magnitude > 0.001 then
                transform.size = transform.size:Lerp(Vector3.new(0, 0, 0), step * 20)
            elseif collected then
                transform.size = Vector3.new(0, 0, 0)
                Sunshine:destroyEntity(entity)
            end
            local entity = collider.hitEntity
            if entity and entity.stats then
                collected = true
                entity.stats.coins = entity.stats.coins + 1
                sound.playing = true
            end
        end, entity)
    end
end