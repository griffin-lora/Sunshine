-- TrafficConeGod

local RunService = game:GetService("RunService")

return function(Sunshine, entity)
    local model = entity.model
    local transform = entity.transform
    local physics = entity.physics
    local customPhysics = entity.customPhysics
    if model and transform and physics then
        local bodyVelocity = Instance.new("BodyVelocity")
        bodyVelocity.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
        bodyVelocity.Velocity = Vector3.new()
        for index, descendant in pairs(model.model:GetDescendants()) do
            if descendant:IsA("BasePart") then
                if physics.welded and descendant ~= model.model.PrimaryPart then
                    local weldConstraint = Instance.new("WeldConstraint")
                    weldConstraint.Part0 = descendant
                    weldConstraint.Part1 = model.model.PrimaryPart
                    weldConstraint.Parent = descendant
                end
                descendant.CustomPhysicalProperties = PhysicalProperties.new(physics.density or 0.7, physics.friction or 0.3, physics.elasticity or 0.5, physics.frictionWeight or 1, physics.elasticityWeight or 1)
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
            __index = function(self, key)
                if not model.model.Parent then
                    setmetatable(physics, {})
                    return Vector3.new()
                end
                if key == "velocity" then
                    return model.model.PrimaryPart.Velocity
                elseif key == "movable" then
                    return not bodyVelocity.Parent
                end
            end,
            __newindex = function(self, key, value)
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
        Sunshine:update(function()
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
        end, entity)
    end
end