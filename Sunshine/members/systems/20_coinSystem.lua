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
	local tag = entity.tag
	local disappear = entity.disappear
	local charData = entity.charData
	local character = entity.character
	local animator = entity.animator
	local physics = entity.physics
	local camera = entity.camera
	local lastcollected = false
    
    if collectible and transform and collider and disappear and sound and transparency then
		if tag.tag == "coin" then
	        local collected = false
	        Sunshine:update(function(step)
				sound.id = nil
	            if collected and transform.size.Magnitude > 0.05 then
	              	transform.size = transform.size:Lerp(Vector3.new(0, 0, 0), step * 20)
	            elseif collected then
	                transform.size = Vector3.new(0, 0, 0)
					transparency.transparency = 1
	            elseif disappear.disappear then
					sound.id = 131323304
					collected = true
	            end
	        end, entity)
		end
    end

	if charData and animator and character and physics then
		Sunshine:update(function()
			if collider.hitEntity and collider.hitEntity.tag and collider.hitEntity.tag.tag == "coin" then
				if not collider.hitEntity.disappear then
					collider.hitEntity.disappear.disappear = true
				end
			end
		end)
	end
	
end