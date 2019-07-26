return function(Sunshine, entityOrId, scene)
    if type(entityOrId) == "string" then
        return Sunshine:getEntityById(entityOrId, scene)
    else
        return entityOrId
    end
end