return function(Sunshine, scene)
    if not Sunshine.callOrder then
        local callOrder = {}
        for fullName, system in pairs(Sunshine.systems) do
            local split = fullName:split("_")
            local index = tonumber(split[1])
            local name = split[2]
            callOrder[index] = system
        end
        Sunshine.callOrder = callOrder
    end
    Sunshine:unloadScene()
    Sunshine.dataScene = scene
    Sunshine.scene = {entities = {}}
    for _, entity in pairs(scene.entities) do
        Sunshine:createEntity(entity)
    end
end