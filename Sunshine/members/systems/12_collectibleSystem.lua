-- SuperMakerPlayer and TrafficConeGod

local plr = game.Players.LocalPlayer
local addCoin = false
local last = 0

return function(Sunshine, entity)
    local collectible = entity.collectible
    local transform = entity.transform
	local transparency = entity.transparency
    local collider = entity.collider
	local sound = entity.sound
	local tag = entity.tag
	local charData = entity.charData
    
    if collectible and transform and collider and sound and transparency then
		if tag.tag == "coin" then
	        local collected = false
	        Sunshine:update(function(step)
				sound.id = nil
	            if collected and transform.size.Magnitude > 0.05 then
	              	transform.size = transform.size:Lerp(Vector3.new(0, 0, 0), step * 20)
	            elseif collected then
	                transform.size = Vector3.new(0, 0, 0)
					transparency.transparency = 1
	            elseif collider.hitEntity and collider.hitEntity.tag and collider.hitEntity.tag.tag == "character" then
	                collected = true
					sound.id = 131323304
					addCoin = true
	            end
	        end)
		end
    end

	if charData then
		last = charData.coins
		Sunshine:update(function()
			if addCoin then
				addCoin = false
				charData.coins = charData.coins + 1
				if charData.coins > 9999 then charData.coins = 9999 end
				last = charData.coins
				local gui = plr.PlayerGui:FindFirstChild("Main")
				if gui ~= nil then
					local counter = gui:FindFirstChild("Counters")
					if counter then
						local text = tostring(charData.coins)
						if string.len(text) < 4 then
							for i=1, 4 - string.len(text) do
								text = "0"..text
							end
						end
						counter.coinIcon.coinCounter.Text = text
					end
				end
			end
			if last ~= charData.coins then
				if charData.coins > 9999 then charData.coins = 9999 end
				local gui = plr.PlayerGui:FindFirstChild("Main")
				if gui ~= nil then
					local counter = gui:FindFirstChild("Counters")
					if counter then
						local text = tostring(charData.coins)
						if string.len(text) < 4 then
							for i=1, 4 - string.len(text) do
								text = "0"..text
							end
						end
						counter.coinIcon.coinCounter.Text = text
					end
				end
				last = charData.coins
			end
		end)
	end
end