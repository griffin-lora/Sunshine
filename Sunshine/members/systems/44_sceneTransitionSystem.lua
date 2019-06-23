local info = TweenInfo.new(0.75, Enum.EasingStyle.Back, Enum.EasingDirection.Out) -- we really need to make TweenInfo into a supported property type for SunshineSuite

return function(Sunshine, entity)
    local sceneTransition = entity.sceneTransition
    local uiTransform = entity.uiTransform
    local visible = entity.visible
    if sceneTransition and uiTransform and visible then
        local loadingScene = false
        local scene
        local startTick = tick()
        Sunshine:update(function(step)
            if loadingScene then
                visible.visible = true
                uiTransform.size = Sunshine:tween(tick() - startTick, info, Vector2.new(1, 1), Vector2.new())
                if (tick() - startTick) > 0.75 then
                    Sunshine:loadScene(scene, true)
                end
            else
                uiTransform.size = Sunshine:tween(tick() - startTick, info, Vector2.new(), Vector2.new(1, 1))
                if (tick() - startTick) > 0.75 then
                   visible.visible = false
                end
            end
        end, entity)
        Sunshine:sceneLoad(function(sceneLoading, load)
            Sunshine.loadingScene = load
            if not loadingScene then
                scene = sceneLoading
                loadingScene = true
                startTick = tick()
            end
        end, entity)
    end
end