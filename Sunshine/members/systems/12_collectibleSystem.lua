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
	local collectedTime = nil
    
	if collectible and transform and collider and sound and transparency then
		local collected = false
		local character = nil
		local stop
		Sunshine:update(function(step)
			if tag.tag == "coin" then
				sound.id = 131323304
				if collected and transform.size.Magnitude > 0.05 then
					transform.size = transform.size:Lerp(Vector3.new(0, 0, 0), step * 20)
				elseif collected then
					transform.size = Vector3.new(0, 0, 0)
					transparency.transparency = 1
				elseif collider.hitEntity and collider.hitEntity.tag and collider.hitEntity.tag.tag == "character" then
					collected = true
					collectedTime = tick()
					stopSound = true
					sound.playing = true
					local charData = collider.hitEntity.charData
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
				if collectedTime then
					if tick() - collectedTime >= 0.65 and stopSound then
						stopSound = false
						sound.playing = false
					end
				end
			elseif tag.tag == "script" then
				sound.id = 1143857273
				if timeSinceLast ~= nil and tick() - timeSinceLast >= 2.85 and removeScript and character then
					removeScript = false
					character.controllable = true
					character.anchored = false
					sound.playing = false
					workspace.CurrentCamera.CameraType = Enum.CameraType.Custom
					Sunshine:unmuteAllSounds()
				end
				if collider.hitEntity and collider.hitEntity.tag and collider.hitEntity.tag.tag == "character" and not collected then
					collected = true
					addScript = true
					sound.playing = true
					transparency.transparency = 1
					Sunshine:muteAllSounds()
					local hitEntity = collider.hitEntity
					character = hitEntity.character
					local animator = hitEntity.animator
					animator.action = 1076799780
					character.controllable = false
					character.anchored = true
					hitEntity.transform.cFrame = CFrame.new(hitEntity.transform.cFrame.Position, Vector3.new(workspace.CurrentCamera.CFrame.Position.X,hitEntity.transform.cFrame.Position.Y,workspace.CurrentCamera.CFrame.Position.Z))
					workspace.CurrentCamera.CameraType = Enum.CameraType.Scriptable
					workspace.CurrentCamera.CFrame = CFrame.new((hitEntity.transform.cFrame.Position + (hitEntity.transform.cFrame.LookVector*12)) + Vector3.new(0,2,0),hitEntity.transform.cFrame.Position)
					removeScript = true
					timeSinceLast = tick()
				end
			end
		end)
    end
end