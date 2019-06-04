-- TrafficConeGod

return function(Sunshine, entity)
    if entity.save then
        entity.save = -- load data
        Sunshine:update(function()
            -- save data
        end)
    end
end