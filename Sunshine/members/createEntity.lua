return function(Sunshine, entity, scene)
    entity = Sunshine:copyTable(entity)
    scene.entities[#scene.entities + 1] = entity
    Sunshine.entityScenes[entity] = scene
    if entity.core.active then
        for _, system in ipairs(Sunshine.callOrder) do
            system(Sunshine, entity, scene)
        end
    else
        warn("Entity " .. entity.core.id .. " is inactive.")
    end
    return entity
end