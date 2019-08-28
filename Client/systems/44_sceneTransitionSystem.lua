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
        local preloading = false
        local dataScene
        Sunshine:update(function()
            if sceneTransition.loading then
                if lastLoading ~= sceneTransition.loading then
                    local player
                    for _, otherEntity in pairs(Sunshine.scenes[1].entities) do
                        if otherEntity.tag and otherEntity.tag.tag == "player" then
                            player = otherEntity
                            break
                        end
                    end
                    unloading = true
                    local cutoutLabel
                    for _, descendant in pairs(frame.frame:GetDescendants()) do
                        if CollectionService:HasTag(descendant, "cutoutLabel") then
                            cutoutLabel = descendant
                        end
                    end
                    if sceneTransition.type == "death" then
                        local screenPoint = workspace.Camera:WorldToScreenPoint(Sunshine:getEntity(player.player.mainCharacter, Sunshine.scenes[1]).transform.cFrame.Position)
                        uiTransform.position = UDim2.new(0, screenPoint.X, 0, screenPoint.Y + 30)
                        cutoutLabel.Image = "rbxassetid://2396957701"
                        dataScene = Sunshine.dataScenes[1]
                    elseif sceneTransition.type == "teleport" then
                        uiTransform.position = UDim2.new(0.5, 0, 0.5, 0)
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
                        uiTransform.position = UDim2.new(0.5, 0, 0.5, 0)
                        if sceneTransition.type == "death" then
                            inBetweenScenes = true
                            Sunshine:unloadScene(Sunshine.scenes[1])
                        else
                            preloading = true
                            Sunshine:loadScene(sceneTransition.scene)
                        end
                    end
                else
                    if inBetweenScenes then
                        if (entity.core.tick - startTick) >= 4 then
                            inBetweenScenes = false
                            startTick = entity.core.tick
                            preloading = true
                            Sunshine:loadScene(dataScene)
                        end
                    elseif not preloading then
                        uiTransform.size = Sunshine:tween(entity.core.tick - startTick, info, Vector2.new(),
                        Vector2.new(1, 1))
                        if (entity.core.tick - startTick) >= info.Time then
                            sceneTransition.loading = false
                            visible.visible = false
                        end
                    else
                        if (entity.core.tick - startTick) >= 1 then
                            startTick = entity.core.tick
                            preloading = false
                        end
                    end
                end
            end
            lastLoading = sceneTransition.loading
        end, entity)
    end
end