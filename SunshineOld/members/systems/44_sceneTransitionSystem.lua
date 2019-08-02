return function(Sunshine, entity, actualScene)
    local sceneTransition = entity.sceneTransition
    local uiTransform = entity.uiTransform
    local visible = entity.visible
    if sceneTransition and uiTransform and visible then
        local loadingScene = false
        local scene
        local startTick = entity.core.tick
        local info = sceneTransition.tweenInfo
        local loading = false
        Sunshine:update(function()
            if loadingScene then
                visible.visible = true
                uiTransform.size = Sunshine:tween(entity.core.tick - startTick, info, Vector2.new(1, 1), Vector2.new())
                if (entity.core.tick - startTick) >= info.Time and not loading then
                    loading = true
                    loadingScene = false
                    Sunshine:loadScene(scene, 1, false)
                    startTick = entity.core.tick
                end
            else
                uiTransform.size = Sunshine:tween(entity.core.tick - startTick, info, Vector2.new(), Vector2.new(1, 1))
                if (entity.core.tick - startTick) >= info.Time then
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
                    startTick = entity.core.tick
                end
                return load or false
            end
        end, entity)
    end
end