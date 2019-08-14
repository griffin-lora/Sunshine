return function(Sunshine, dataEntity, scene)
    if dataEntity.core then
        if dataEntity.core.active then
            local entity = {
                core = {
                    name = dataEntity.core.name,
                    id = dataEntity.core.id,
                    active = dataEntity.core.active,
                    scene = scene,
                    tick = 0,
                    updateCallbacks = {},
                    instances = {},
                    connections = {},
                    sceneUnloadCallbacks = {},
                    entityDestroyCallbacks = {},
                    dataEntity = dataEntity
                }
            }
            for componentName, dataComponent in pairs(dataEntity) do
                if componentName ~= "core" then
                    local component = {}
                    for name, value in pairs(dataComponent) do
                        component[name] = value
                    end
                    entity[componentName] = component
                end
            end
            scene.entities[#scene.entities + 1] = entity
            for _, system in ipairs(Sunshine.systems) do
                system(Sunshine, entity, scene)
            end
            return entity
        end
    else
        error("Entity does not have a core component.")
    end
end