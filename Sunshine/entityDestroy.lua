return function(_, callback, entity)
    entity.core.entityDestroyCallbacks[#entity.core.entityDestroyCallbacks + 1] = callback
end