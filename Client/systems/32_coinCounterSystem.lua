local CollectionService = game:GetService("CollectionService")

-- SuperMakerPlayer and TrafficConeGod
return function(Sunshine, entity)
    local coinCounter = entity.coinCounter
    local frame = entity.frame
    local last = 0
    local lastReg = 0
    if coinCounter and frame then
        Sunshine:update(function()
            if Sunshine.scenes[1] then
                local player = Sunshine:getEntity(coinCounter.player, Sunshine.scenes[1])
                if player then
                    local stats = player.stats
                    if stats then
                        if last ~= stats.coins then
                            last = stats.coins
                            local text = stats.coins
                            for _ = 1, 4 - #tostring(text) do
                                text = "0"..text
                            end
                            for _,p in pairs(frame.frame:GetDescendants()) do
                                if CollectionService:HasTag(p, "coinsLabel") then
                                    p.Text = text
                                end
                            end
                        end
                        if lastReg ~= stats.regionalCoins then
                            lastReg = stats.regionalCoins
                            local text = stats.regionalCoins
                            for _ = 1, 3 - #tostring(text) do
                                text = "0"..text
                            end
                            for _,p in pairs(frame.frame:GetDescendants()) do
                                if CollectionService:HasTag(p, "regionalCoinsLabel") then
                                    p.Text = text
                                end
                            end
                        end
                    end
                end
            end
        end, entity)
    end
end