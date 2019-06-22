return function(Sunshine, entity)
    local sceneTransition = entity.sceneTransition
    local uiTransform = entity.uiTransform
    if sceneTransition and uiTransform then
        local loadingScene = false
        local scene
        Sunshine:update(function(step)
            if loadingScene then
                uiTransform.size = uiTransform.size:Lerp(Vector2.new(), step * 8)
                if (uiTransform.size - Vector2.new()).Magnitude < 0.01 then
                    Sunshine:loadScene(scene, true)
                end
            else
                uiTransform.size = uiTransform.size:Lerp(Vector2.new(1, 1), step * 8)
            end
        end, entity)
        Sunshine:sceneLoad(function(sceneLoading, load)
            Sunshine.loadingScene = load
            scene = sceneLoading
            loadingScene = true
        end, entity)
    end
end