return function(Sunshine, entity, actualScene)
    local sceneTransition = entity.sceneTransition
    local uiTransform = entity.uiTransform
    local visible = entity.visible
    if sceneTransition and uiTransform and visible then
        local loadingScene = false
        local scene
        local startTick = Sunshine:tick(actualScene)
        local info = sceneTransition.tweenInfo
        local loading = false
        Sunshine:update(function()
            if loadingScene then
                visible.visible = true
                uiTransform.size = Sunshine:tween(Sunshine:tick(actualScene) - startTick, info, Vector2.new(1, 1), Vector2.new())
                if (Sunshine:tick(actualScene) - startTick) >= info.Time and not loading then
                    loading = true
                    loadingScene = false
                    Sunshine:loadScene(scene, 1, false)
                    startTick = Sunshine:tick(actualScene)
                end
            else
                uiTransform.size = Sunshine:tween(Sunshine:tick(actualScene) - startTick, info, Vector2.new(), Vector2.new(1, 1))
                if (Sunshine:tick(actualScene) - startTick) >= info.Time then
                    visible.visible = false
                end
            end
        end, entity)
        Sunshine:sceneLoad(function(sceneLoading, sceneIndex, load)
            if sceneIndex == 1 and load ~= false then
                loading = false
                if not loadingScene then
                    scene = sceneLoading
                    loadingScene = true
                    startTick = Sunshine:tick(actualScene)
                end
                return load or false
            end
        end, entity)
    end
end