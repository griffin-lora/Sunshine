return function(Sunshine, entity)
    entity = Sunshine:copyTable(entity)
    if entity.core.active then
        Sunshine.scene.entities[#Sunshine.scene.entities + 1] = entity
        for _, system in ipairs(Sunshine.callOrder) do
            system(Sunshine, entity)
        end
    else
        warn("Entity " .. entity.core.id .. " is inactive.")
    end
end