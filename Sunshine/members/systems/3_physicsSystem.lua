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
        local lastVelocity = model.model.PrimaryPart.Velocity
        local lastAngularVelocity = model.model.PrimaryPart.RotVelocity
        Sunshine:update(function()
            for index, descendant in pairs(model.model:GetDescendants()) do
                if descendant:IsA("BasePart") then
                    descendant.Anchored = physics.anchored
                    descendant.CanCollide = physics.canCollide
                    descendant.Massless = physics.massless
                end
            end
            -- This is to check if the velocity has been changed from another system.
            if physics.velocity ~= lastVelocity then
                model.model.PrimaryPart.Velocity = physics.velocity
            else
                physics.velocity = model.model.PrimaryPart.Velocity
            end
            if physics.angularVelocity ~= lastAngularVelocity then
                model.model.PrimaryPart.RotVelocity = physics.angularVelocity
            else
                physics.angularVelocity = model.model.PrimaryPart.RotVelocity
            end
            lastVelocity = model.model.PrimaryPart.Velocity
            lastAngularVelocity = model.model.PrimaryPart.RotVelocity
            if not physics.anchored then
                transform.cFrame = model.model:GetPrimaryPartCFrame()
            end
        end)
    end
end