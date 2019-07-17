return function(Sunshine, sceneIndex)
    local scene = Sunshine.scenes[sceneIndex]
    if scene then
        Sunshine.scenes[sceneIndex] = nil
        scene.active = false
        for _, entity in pairs(scene.entities) do
            Sunshine:destroyEntity(entity)
        end
    end
end