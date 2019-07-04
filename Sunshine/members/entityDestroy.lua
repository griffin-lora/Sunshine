return function(Sunshine, callback, entity)
    if not entity then
        error("entityDestroy is being used without entity specification.")
    end
    Sunshine.entityDestroyCallbacks[#Sunshine.entityDestroyCallbacks + 1] = {callback, entity}
end