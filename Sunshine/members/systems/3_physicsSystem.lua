local RunService = game:GetService("RunService")

return function(Sunshine, entity)
    local model = entity.model
    local transform = entity.transform
    local physics = entity.physics
    local customPhysics = entity.customPhysics
    if model and transform and physics then
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
        physics.velocity = nil
        setmetatable(physics, {
            __index = function(self, key)
                if key == "velocity" then
                    return model.model.PrimaryPart.Velocity
                end
            end,
            __newindex = function(self, key, value)
                if key == "velocity" then
                    model.model.PrimaryPart.Velocity = value
                end
            end
        })
        Sunshine:update(function()
            for index, descendant in pairs(model.model:GetDescendants()) do
                if descendant:IsA("BasePart") then
                    descendant.Anchored = physics.anchored
                    descendant.Massless = physics.massless
                    if descendant.CanCollide then
                        descendant.CanCollide = physics.canCollide
                    end
                end
            end
        end)
    end
end