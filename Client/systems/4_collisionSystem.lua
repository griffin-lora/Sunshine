-- TrafficConeGod

return function(Sunshine, entity)
    local collider = entity.collider
    local model = entity.model
    if collider and model then
        Sunshine:addConnection(model.model.PrimaryPart.Touched, function(part)
            if collider.trigger and part.Parent and part.Parent:IsA("Model") and part.Parent.PrimaryPart == part then
                local hitEntity = Sunshine:getEntity(part.Parent.Name, entity.core.scene)
                if hitEntity and hitEntity.collider and not hitEntity.collider.anchored then
                    collider.hitEntity = hitEntity
                end
            end
        end, entity)
        Sunshine:addConnection(model.model.PrimaryPart.TouchEnded, function(part)
            if collider.trigger and part.Parent and part.Parent:IsA("Model") and part.Parent.PrimaryPart == part then
                local hitEntity = Sunshine:getEntity(part.Parent.Name, entity.core.scene)
                if hitEntity and hitEntity.collider and not hitEntity.collider.anchored then
                    collider.hitEntity = nil
                end
            end
        end, entity)
        Sunshine:update(function()
            local parts = model.model.PrimaryPart:GetTouchingParts()
            for _, part in pairs(parts) do
                if collider.trigger and part.Parent and part.Parent:IsA("Model") and part.Parent.PrimaryPart == part
                then
                    local hitEntity = Sunshine:getEntity(part.Parent.Name, entity.core.scene)
                    if hitEntity and hitEntity.collider and hitEntity.collider.anchored then
                        collider.hitEntity = hitEntity
                    end
                end
            end
            if not collider.trigger then
                collider.hitEntity = nil
            end
        end, entity)
    end
end