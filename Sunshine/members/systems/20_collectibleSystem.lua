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
	local charData = entity.charData
	local character = entity.character
	local animator = entity.animator
	local physics = entity.physics
	local camera = entity.camera
	local lastcollected = false
    
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
	        end, entity)
		elseif tag.tag == "script" then
			local collected = false
			Sunshine:update(function()
				sound.id = nil
				if collider.hitEntity and collider.hitEntity.tag and collider.hitEntity.tag.tag == "character" and not collected then
					collected = true
					addScript = true
					sound.id = 1143857273
					transparency.transparency = 1
				end
			end, entity)
		end
    end

	if charData and animator and character and physics then
		last = charData.coins
		Sunshine:update(function()
			if addCoin then
				addCoin = false
				charData.coins = charData.coins + 1
				if charData.coins > 9999 then charData.coins = 9999 end
				last = charData.coins
				local gui = plr.PlayerGui:FindFirstChild("ScreenGui")
				if gui ~= nil then
					local counter = gui:FindFirstChild("CoinsFrame")
					if counter then
						local text = tostring(charData.coins)
						if string.len(text) < 4 then
							for i=1, 4 - string.len(text) do
								text = "0"..text
							end
						end
						counter.RegularFrame.RegularCoinsLabel.Text = text
					end
				end
			end

			if last ~= charData.coins then
				if charData.coins > 9999 then charData.coins = 9999 end
				local gui = plr.PlayerGui:FindFirstChild("ScreenGui")
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
			
			if timeSinceLast ~= nil and workspace.DistributedGameTime - timeSinceLast >= 2.85 and removeScript then
				removeScript = false
				character.controllable = true
				character.anchored = false
				workspace.CurrentCamera.CameraType = Enum.CameraType.Custom
				Sunshine:unmuteAllSounds()
			end

			if addScript then
				addScript = false
				Sunshine:muteAllSounds()
				animator.action = 1076799780
				character.controllable = false
				character.anchored = true
				transform.cFrame = CFrame.new(transform.cFrame.Position, Vector3.new(workspace.CurrentCamera.CFrame.Position.X,transform.cFrame.Position.Y,workspace.CurrentCamera.CFrame.Position.Z))
				workspace.CurrentCamera.CameraType = Enum.CameraType.Scriptable
				workspace.CurrentCamera.CFrame = CFrame.new((transform.cFrame.Position + (transform.cFrame.LookVector*12)) + Vector3.new(0,2,0),transform.cFrame.Position)
				removeScript = true
				timeSinceLast = workspace.DistributedGameTime
			end

		end)
	end
	
end