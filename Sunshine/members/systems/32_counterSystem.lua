-- SuperMakerPlayer and TrafficConeGod
return function(Sunshine, entity)
    local coin = entity.coinCounter
    local charObject = entity.charObject
    local label = entity.label
    local last = 0

    if coin and charObject and label then
        Sunshine:update(function()
            local char = Sunshine:getEntity(charObject.object)
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