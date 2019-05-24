return function(Sunshine, entity)
    local animator = entity.animator
    local model = entity.model
    if animator and model then
        local animationController = Instance.new("AnimationController")
        animationController.Parent = model.model
        local core = animator.core
        local coreTrack
        local idle = animator.idle
        local idleTrack
        local movement = animator.movement
        local movementTrack
        local action = animator.action
        local actionTrack
        Sunshine:update(function()
            if action ~= animator.action then
                action = animator.action
                if animator.action then
                    local animation = Instance.new("Animation")
                    animation.AnimationId = "rbxassetid://"..action
                    actionTrack = animationController:LoadAnimation(animation)
                    actionTrack.Priority = Enum.AnimationPriority.Action
                    actionTrack:Play()
                else
                    actionTrack:Stop()
                end
            end
            if movement ~= animator.movement then
                movement = animator.movement
                if animator.movement then
                    local animation = Instance.new("Animation")
                    animation.AnimationId = "rbxassetid://"..movement
                    movementTrack = animationController:LoadAnimation(animation)
                    movementTrack.Priority = Enum.AnimationPriority.Movement
                    movementTrack:Play()
                else
                    movementTrack:Stop()
                end
            end
            if idle ~= animator.idle then
                idle = animator.idle
                if animator.idle then
                    local animation = Instance.new("Animation")
                    animation.AnimationId = "rbxassetid://"..idle
                    idleTrack = animationController:LoadAnimation(animation)
                    idleTrack.Priority = Enum.AnimationPriority.Idle
                    idleTrack:Play()
                else
                    idleTrack:Stop()
                end
            end
            if core ~= animator.core then
                core = animator.core
                if animator.core then
                    local animation = Instance.new("Animation")
                    animation.AnimationId = "rbxassetid://"..core
                    coreTrack = animationController:LoadAnimation(animation)
                    coreTrack.Priority = Enum.AnimationPriority.Core
                    coreTrack:Play()
                else
                    coreTrack:Stop()
                end
            end
        end)
    end
end