local Selection = game:GetService("Selection")

return function(Sunshine, entity)
    local loader = entity.loader
    local button = entity.button
    print(loader,button)
    if loader and button then
        print("E")
        Sunshine:update(function()
            print(button.activated)
        end, entity)
    end
end