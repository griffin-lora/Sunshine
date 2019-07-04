return function(Sunshine, entity)
    local sceneTransition = entity.sceneTransition
    local uiTransform = entity.uiTransform
    local visible = entity.visible
    if sceneTransition and uiTransform and visible then
        local loadingScene = false
        local scene
        local startTick = tick()
        local info = sceneTransition.tweenInfo
        local loading = false
        Sunshine:update(function()
            if loadingScene then
                visible.visible = true
                uiTransform.size = Sunshine:tween(tick() - startTick, info, Vector2.new(1, 1), Vector2.new())
                if (tick() - startTick) > info.Time and not loading then
                    loading = true
                    Sunshine:loadScene(scene, true)
                end
            else
                uiTransform.size = Sunshine:tween(tick() - startTick, info, Vector2.new(), Vector2.new(1, 1))
                if (tick() - startTick) > info.Time then
                   visible.visible = false
                end
            end
        end, entity)
        Sunshine:sceneLoad(function(sceneLoading, load)
            if not loadingScene then
                scene = sceneLoading
                loadingScene = true
                startTick = tick()
            end
            return load or false
        end, entity)
    end
end