return function(Sunshine, entity)
    local sceneTransition = entity.sceneTransition
    local uiTransform = entity.uiTransform
    if sceneTransition and uiTransform then
        local loadingScene = false
        local scene
        local startTick = tick()
        Sunshine:update(function(step)
            print(Sunshine:tween(tick() - startTick, TweenInfo.new(10, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), 0, 10))
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