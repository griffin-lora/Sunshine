-- TrafficConeGod

return function(Sunshine, entity, scene)
    local model = entity.model
    local transform = entity.transform
    local physics = entity.physics
    local lockAxis = entity.lockAxis
    if model and transform and physics then
        local bodyVelocity = Instance.new("BodyVelocity")
        bodyVelocity.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
        bodyVelocity.Velocity = Vector3.new()
        local pauseBodyVelocity = Instance.new("BodyVelocity")
        pauseBodyVelocity.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
        pauseBodyVelocity.Velocity = Vector3.new()
        if lockAxis then
            local x = 0
            local y = 0
            local z = 0
            if lockAxis.x then
                x = math.huge
            end
            if lockAxis.y then
                y = math.huge
            end
            if lockAxis.z then
                z = math.huge
            end
            local lockAxisBodyVelocity = Instance.new("BodyVelocity")
            lockAxisBodyVelocity.MaxForce = Vector3.new(x, y, z)
            lockAxisBodyVelocity.Velocity = Vector3.new()
            lockAxisBodyVelocity.Parent = model.model.PrimaryPart
            for _, descendant in pairs(model.model:GetDescendants()) do
                if descendant:IsA("BasePart") then
                    lockAxisBodyVelocity:Clone().Parent = descendant
                end
            end
        end
        for _, descendant in pairs(model.model:GetDescendants()) do
            if descendant:IsA("BasePart") then
                if physics.welded and descendant ~= model.model.PrimaryPart then
                    local weldConstraint = Instance.new("WeldConstraint")
                    weldConstraint.Part0 = descendant
                    weldConstraint.Part1 = model.model.PrimaryPart
                    weldConstraint.Parent = descendant
                end
                descendant.CustomPhysicalProperties = PhysicalProperties.new(physics.density or 0.7,
                physics.friction or 0.3, physics.elasticity or 0.5, physics.frictionWeight or 1,
                physics.elasticityWeight or 1)
            end
        end
        if physics.movable then
            bodyVelocity.Parent = nil
        else
            bodyVelocity.Parent = model.model.PrimaryPart
        end
        physics.velocity = nil
        physics.movable = nil
        setmetatable(physics, {
            __index = function(_, key)
                if not model.model.Parent then
                    setmetatable(physics, {})
                    physics.velocity = Vector3.new()
                    return Vector3.new()
                end
                if key == "velocity" then
                    return model.model.PrimaryPart.Velocity or Vector3.new()
                elseif key == "movable" then
                    return not bodyVelocity.Parent
                end
            end,
            __newindex = function(_, key, value)
                if not model.model.Parent then
                    setmetatable(physics, {})
                    return
                end
                if key == "velocity" then
                    model.model.PrimaryPart.Velocity = value
                elseif key == "movable" then
                    if value then
                        bodyVelocity.Parent = nil
                    else
                        bodyVelocity.Parent = model.model.PrimaryPart
                    end
                end
            end
        })
        local pauseVelocity
        Sunshine:update(function()
            if not scene.paused then
                pauseBodyVelocity.Parent = nil
                if pauseVelocity then
                    model.model.PrimaryPart.Velocity = pauseVelocity
                end
                pauseVelocity = nil
                local descendants = model.model:GetDescendants()
                for index = 1, #descendants do
                    local descendant = descendants[index]
                    if descendant:IsA("BasePart") then
                        if descendant.Anchored then
                            descendant.Anchored = physics.anchored
                        end
                        descendant.Massless = physics.massless
                        if descendant.CanCollide then
                            descendant.CanCollide = physics.canCollide
                        end
                    end
                end
            else
                pauseBodyVelocity.Parent = model.model.PrimaryPart
                if not pauseVelocity then
                    pauseVelocity = model.model.PrimaryPart.Velocity
                else
                    model.model.PrimaryPart.Velocity = pauseVelocity
                end
            end
        end, entity, true)
    end
end