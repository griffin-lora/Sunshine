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
            if not animationTrack then
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
            if action ~= animator.action then
                action = animator.action
                if actionTrack then
                    actionTrack:Stop()
                end
                if animator.action then
                    actionTrack = loadAnimation(action)
                    actionTrack.Priority = Enum.AnimationPriority.Action
                    actionTrack:Play()
                end
            end
            if movement ~= animator.movement then
                movement = animator.movement
                if movementTrack then
                    movementTrack:Stop()
                end
                if animator.movement then
                    movementTrack = loadAnimation(movement)
                    movementTrack.Priority = Enum.AnimationPriority.Movement
                    movementTrack:Play()
                end
            end
            if idle ~= animator.idle then
                idle = animator.idle
                if idleTrack then
                    idleTrack:Stop()
                end
                if animator.idle then
                    idleTrack = loadAnimation(idle)
                    idleTrack.Priority = Enum.AnimationPriority.Idle
                    idleTrack:Play()
                end
            end
            if core ~= animator.core then
                core = animator.core
                if coreTrack then
                    coreTrack:Stop()
                end
                if animator.core then
                    coreTrack = loadAnimation(core)
                    coreTrack.Priority = Enum.AnimationPriority.Core
                    coreTrack:Play()
                end
            end
        end)
    end
end