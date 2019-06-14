-- SuperMakerPlayer and TrafficConeGod

local plr = game.Players.LocalPlayer
local addCoin = false
local addScript = false
local last = 0
local timeSinceLast = nil
local removeScript = false

return function(Sunshine, entity)
    local collectible = entity.collectible
    local transform = entity.transform
	local transparency = entity.transparency
    local collider = entity.collider
	local sound = entity.sound
	local coin = entity.coin
    
    if collectible and transform and collider and sound and transparency then
		if coin then
	        local collected = false
	        Sunshine:update(function(step)
				sound.id = nil
	            if collected and transform.size.Magnitude > 0.05 then
	              	transform.size = transform.size:Lerp(Vector3.new(0, 0, 0), step * 20)
	            elseif collected then
	                transform.size = Vector3.new(0, 0, 0)
					transparency.transparency = 1
				end
				local entity = collider.hitEntity
				if entity and entity.stats then
					sound.id = 131323304
					collected = true
				end
	        end, entity)
		end
    end
end