return function(Sunshine, entityOrId)
    if type(entityOrId) == "string" then
        return Sunshine:getEntityById(entityOrId)
    else
        return entityOrId
    end
end