local state = "state"

return function(Sunshine, entity)
    local component = entity[state]
    local character = entity.character
    local input = entity.input
    local transform = entity.transform
    local physics = entity.physics
    local animator = entity.animator
    Sunshine:createStateSystem(entity, state, function()
        -- start check
        return 
    end, function()
        -- start
    end, function()
        -- update
    end, function()
        -- end check
        return
    end, function()
        -- end
    end, function()
        -- general update
    end)
end