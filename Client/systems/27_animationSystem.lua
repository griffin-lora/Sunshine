-- TrafficConeGod

return function(Sunshine, entity)
    local animation = entity.animation
    local model = entity.model
    if animation and model then
        local animationController = Instance.new("AnimationController")
        animationController.Parent = model.model
        local lastId
        local animationTrack
        Sunshine:update(function()
            if animation.id ~= lastId then
                if animation.id then
                    if animationTrack then
                        animationTrack:Destroy()
                    end
                    local animationInstance = Instance.new("Animation")
                    animationInstance.AnimationId = "rbxassetid://"..animation.id
                    animationTrack = animationController:LoadAnimation(animationInstance)
                end
            end
            if animationTrack then
                if animation.playing then
                    if not animationTrack.IsPlaying then
                        animationTrack:Play()
                    end
                else
                    if animation.IsPlaying then
                        animationTrack:Stop()
                    end
                end
                animationTrack:AdjustSpeed(animation.speed)
                animationTrack.Looped = animation.looped
            end
			lastId = animation.id
        end, entity)
    end
end