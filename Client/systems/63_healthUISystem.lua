local CollectionService = game:GetService("CollectionService")

return function(Sunshine, entity)
    local healthUI = entity.healthUI
    local frame = entity.frame

    if healthUI and frame then
        Sunshine:update(function()
            if Sunshine.scenes[1] then
                local player = Sunshine:getEntity(healthUI.player, Sunshine.scenes[1])
                if player then
                    local mainCharacter = Sunshine:getEntity(player.player.mainCharacter, Sunshine.scenes[1])
                    if mainCharacter then
                        local health = mainCharacter.health
                        if health then
                            for _,p in pairs(frame.frame:GetDescendants()) do
                                if CollectionService:HasTag(p, "healthLabel") then
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
                                end
                            end
                        end
                    end
                end
            end
        end, entity)
    end
end