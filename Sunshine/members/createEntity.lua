return function(Sunshine, entity)
    entity = Sunshine:copyTable(entity)
    Sunshine.scene.entities[#Sunshine.scene.entities + 1] = entity
    if entity.core.active then
        for _, system in ipairs(Sunshine.callOrder) do
            system(Sunshine, entity)
        end
    else
        warn("Entity " .. entity.core.id .. " is inactive.")
    end
    return entity
end