return function(Sunshine, entity)
    local stats = entity.stats
    local store = entity.store
    if stats and store then
        local loaded = false
        Sunshine:update(function()
            if store.save and not loaded then
                entity.stats = store.save.stats or stats
                stats = entity.stats
                store.save.stats = stats
                loaded = true
            end
        end, entity)
    end
end