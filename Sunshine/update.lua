return function(_, callback, entity, ignoreInactive)
    entity.core.updateCallbacks[#entity.core.updateCallbacks + 1] = {callback, ignoreInactive}
end