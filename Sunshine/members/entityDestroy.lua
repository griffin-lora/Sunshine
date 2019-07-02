return function(Sunshine, callback, entity)
    if not entity then
        warn("entityDestroy is being used without entity specification.")
    end
    Sunshine.entityDestroyCallbacks[#Sunshine.entityDestroyCallbacks + 1] = {callback, entity}
end