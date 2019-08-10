return function(Sunshine, entity)
    local change = entity.change
    if change then
        Sunshine:update(function()
            if change.change then
                print(change.component, change.propertyName)
                -- other shit will handle the rest
                change.change = nil
            end
        end, entity)
    end
end