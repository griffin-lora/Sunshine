return function(Sunshine, callback, entity)
    if not entity then
        warn("sceneLoad is being used without entity specification.")
    end
    Sunshine.sceneLoadCallbacks[#Sunshine.sceneLoadCallbacks + 1] = {callback, entity}
end