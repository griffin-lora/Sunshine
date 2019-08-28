local CollectionService = game:GetService("CollectionService")
local TWEENINFO_BACK = TweenInfo.new(0.35, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, 0, false, 0)
local CHARACTER_POSITION_OFFSET = 70

return function(Sunshine, entity)
    local healthUI = entity.healthUI
    local frame = entity.frame
    local lastHealth
    local startTick
    local startTickBack
    local firstPosition
    local screenPointPosition

    if healthUI and frame then
        Sunshine:update(function()
            if Sunshine.scenes[1] then
                local player = Sunshine:getEntity(healthUI.player, Sunshine.scenes[1])
                if player then
                    local mainCharacter = Sunshine:getEntity(player.player.mainCharacter, Sunshine.scenes[1])
                    if mainCharacter then
                        local health = mainCharacter.health
                        if not lastHealth then
                            lastHealth = health.health
                        end
                        if health then
                            for _,p in pairs(frame.frame:GetDescendants()) do
                                if CollectionService:HasTag(p, "healthLabel") then
                                    if not firstPosition then
                                        firstPosition = p.Position
                                    end
                                    p.Image = "rbxassetid://"..healthUI.image
                                    if health.health >= 3 then
                                        p.ImageRectOffset = healthUI.rectOffset3
                                    elseif health.health == 2 then
                                        p.ImageRectOffset = healthUI.rectOffset2
                                    elseif health.health == 1 then
                                        p.ImageRectOffset = healthUI.rectOffset1  
                                    else
                                        p.ImageRectOffset = healthUI.rectOffset0
                                    end
                                    if health.health ~= lastHealth and health.health ~= 0 and (health.health ~= 3 and lastHealth ~= 0) then
                                        local screenPoint = workspace.Camera:WorldToScreenPoint(mainCharacter.transform.cFrame.Position)
                                        p.Position = UDim2.new(0, screenPoint.X, 0, screenPoint.Y - CHARACTER_POSITION_OFFSET)
                                        screenPointPosition = p.Position
                                        startTick = entity.core.tick
                                        startTickBack = nil
                                    end
                                    if startTick and entity.core.tick - startTick > 2 then
                                        startTick = nil
                                        startTickBack = entity.core.tick 
                                    end
                                    if startTickBack and entity.core.tick - startTickBack < 0.35 then
                                        p.Position = Sunshine:tween(entity.core.tick - startTickBack, TWEENINFO_BACK,
                                        screenPointPosition, firstPosition)
                                    elseif startTickBack then
                                        startTickBack = nil
                                    end
                                end
                            end
                            lastHealth = health.health
                        end
                    end
                end
            end
        end, entity)
    end
end