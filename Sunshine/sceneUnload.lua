return function(_, callback, entity)
    entity.core.sceneUnloadCallbacks[#entity.core.sceneUnloadCallbacks + 1] = callback
end