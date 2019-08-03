-- SuperMakerPlayer and TrafficConeGod
return function(Sunshine, entity)
    local coinCounter = entity.coinCounter
    local label = entity.label
    local last = 0
    if coinCounter and label then
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
                            label.text = text
                        end
                    end
                end
            end
        end, entity)
    end
end