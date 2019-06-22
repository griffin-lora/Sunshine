return function(Sunshine, entity)
    local stats = entity.stats
    local store = entity.store
    if stats and store then
        local loaded = false
        Sunshine:update(function()
            if store.save then
                if loaded then
                    store.save.stats = Sunshine:copyTable(stats)
                else
                    entity.stats = Sunshine:copyTable(store.save.stats) or stats
                    stats = entity.stats
                    loaded = true
                end
            end
        end, entity)
    end
end