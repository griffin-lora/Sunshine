-- SuperMakerPlayer and TrafficConeGod
return function(Sunshine, entity)
    local coinCounter = entity.coinCounter
    local label = entity.label
    local last = 0

    if coinCounter and label then
        Sunshine:update(function()
            local char = Sunshine:getEntity(coinCounter.player, Sunshine.scenes[1])
            if char then
                local stats = char.stats
                if stats then
                    if last ~= stats.coins then
                        last = stats.coins
                        local text = stats.coins
                        for _ = 1, 4 - tostring(text):len() do
                            text = "0"..text
                        end
                        label.text = text
                    end
                end
            end
        end, entity)
    end
end