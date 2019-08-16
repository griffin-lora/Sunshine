local CollectionService = game:GetService("CollectionService")

return function(Sunshine, entity)
    local frame = entity.frame
    local sceneTransition = entity.sceneTransition
    local uiTransform = entity.uiTransform
    local visible = entity.visible
    if frame and sceneTransition and uiTransform and visible then
        local startTick = entity.core.tick
        local info = sceneTransition.tweenInfo
        local lastLoading
        local unloading
        local inBetweenScenes = false
        local dataScene
        Sunshine:update(function()
            if sceneTransition.loading then
                if lastLoading ~= sceneTransition.loading then
                    unloading = true
                    local cutoutLabel
                    for _, descendant in pairs(frame.frame:GetDescendants()) do
                        if CollectionService:HasTag(descendant, "cutoutLabel") then
                            cutoutLabel = descendant
                        end
                    end
                    if sceneTransition.type == "death" then
                        cutoutLabel.Image = "rbxassetid://2676141005"
                        dataScene = Sunshine.dataScenes[1]
                    elseif sceneTransition.type == "teleport" then
                        cutoutLabel.Image = "rbxassetid://2676141005"
                    end
                    visible.visible = true
                    startTick = entity.core.tick
                end
                if unloading then
                    uiTransform.size = Sunshine:tween(entity.core.tick - startTick, info, Vector2.new(1, 1),
                    Vector2.new())
                    if (entity.core.tick - startTick) >= info.Time then
                        startTick = entity.core.tick
                        unloading = false
                        if sceneTransition.type == "death" then
                            inBetweenScenes = true
                            Sunshine:unloadScene(Sunshine.scenes[1])
                        else
                            Sunshine:loadScene(sceneTransition.scene)
                        end
                    end
                else
                    if inBetweenScenes then
                        if (entity.core.tick - startTick) >= 5 then
                            inBetweenScenes = false
                            startTick = entity.core.tick
                            Sunshine:loadScene(dataScene)
                        end
                    else
                        uiTransform.size = Sunshine:tween(entity.core.tick - startTick, info, Vector2.new(),
                        Vector2.new(1, 1))
                        if (entity.core.tick - startTick) >= info.Time then
                            sceneTransition.loading = false
                            visible.visible = false
                        end
                    end
                end
            end
            lastLoading = sceneTransition.loading
        end, entity)
    end
end