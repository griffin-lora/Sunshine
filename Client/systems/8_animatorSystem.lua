-- TrafficConeGod

return function(Sunshine, entity)
    local animator = entity.animator
    local model = entity.model
    if animator and model then
        local animationController = Instance.new("AnimationController")
        animationController.Parent = model.model
        local animationTracks = {}
        local function loadAnimation(id)
            local animationTrack = animationTracks[id]
            if not animationTrack and animationController.Parent then
                local animation = Instance.new("Animation")
                animation.AnimationId = "rbxassetid://"..id
                animationTrack = animationController:LoadAnimation(animation)
                animationTracks[id] = animationTrack
            end
            return animationTrack
        end
        local core = animator.core
        local coreTrack
        local idle = animator.idle
        local idleTrack
        local movement = animator.movement
        local movementTrack
        local action = animator.action
        local actionTrack
        Sunshine:update(function()
            if entity.core.active and entity.core.scene.active then
                if actionTrack then
                    actionTrack:AdjustSpeed(animator.actionSpeed or 1)
                end
                if movementTrack then
                    movementTrack:AdjustSpeed(animator.movementSpeed or 1)
                end
                if idleTrack then
                    idleTrack:AdjustSpeed(animator.idleSpeed or 1)
                end
                if coreTrack then
                    coreTrack:AdjustSpeed(animator.coreSpeed or 1)
                end
                if action ~= animator.action then
                    action = animator.action
                    if actionTrack then
                        actionTrack:Stop()
                    end
                    if animator.action then
                        actionTrack = loadAnimation(action)
                        if actionTrack then
                            actionTrack.Priority = Enum.AnimationPriority.Action
                            actionTrack:Play()
                        end
                    end
                end
                if movement ~= animator.movement then
                    movement = animator.movement
                    if movementTrack then
                        movementTrack:Stop()
                    end
                    if animator.movement then
                        movementTrack = loadAnimation(movement)
                        if movementTrack then
                            movementTrack.Priority = Enum.AnimationPriority.Movement
                            movementTrack:Play()
                        end
                    end
                end
                if idle ~= animator.idle then
                    idle = animator.idle
                    if idleTrack then
                        idleTrack:Stop()
                    end
                    if animator.idle then
                        idleTrack = loadAnimation(idle)
                        if idleTrack then
                            idleTrack.Priority = Enum.AnimationPriority.Idle
                            idleTrack:Play()
                        end
                    end
                end
                if core ~= animator.core then
                    core = animator.core
                    if coreTrack then
                        coreTrack:Stop()
                    end
                    if animator.core then
                        coreTrack = loadAnimation(core)
                        if coreTrack then
                            coreTrack.Priority = Enum.AnimationPriority.Core
                            coreTrack:Play()
                        end
                    end
                end
            else
                if actionTrack then
                    actionTrack:AdjustSpeed(0)
                end
                if movementTrack then
                    movementTrack:AdjustSpeed(0)
                end
                if idleTrack then
                    idleTrack:AdjustSpeed(0)
                end
                if coreTrack then
                    coreTrack:AdjustSpeed(0)
                end
            end
        end, entity, true)
    end
end