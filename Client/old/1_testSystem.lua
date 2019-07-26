return function(Sunshine, entity)
    Sunshine:update(function()
        print(entity.core.tick)
    end, entity)
end