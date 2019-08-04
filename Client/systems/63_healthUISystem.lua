local CollectionService = game:GetService("CollectionService")

return function(Sunshine, entity)
    local healthUI = entity.healthUI
    local frame = entity.frame
    local lastHealth

    if healthUI and frame then
        Sunshine:update(function()
            if Sunshine.scenes[1] then
                local player = Sunshine:getEntity(healthUI.player, Sunshine.scenes[1])
                if player then
                    local mainCharacter = Sunshine:getEntity(player.player.mainCharacter, Sunshine.scenes[1])
                    if mainCharacter then
                        if mainCharacter.health then
                            local health = mainCharacter.health.health
                            if health ~= lastHealth then
                                lastHealth = health
                                for _,p in pairs(frame.frame:GetDescendants()) do
                                    if CollectionService:HasTag(p, "healthLabel") then
                                        if health >= 3 then
                                            p.ImageRectOffset = healthUI.rectOffset3
                                        elseif health == 2 then
                                            p.ImageRectOffset = healthUI.rectOffset2
                                        elseif health == 1 then
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
            end
        end, entity)
    end
end