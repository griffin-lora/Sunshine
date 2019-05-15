return function(Sunshine, entity)
    local collider = entity.collider
    local model = entity.model
    if collider and model and collider.trigger then
        Sunshine:addConnection(model.model.PrimaryPart.Touched, function(part)
            if part.Parent and part.Parent:IsA("Model") and part.Parent.PrimaryPart == part then
                local hitEntity = Sunshine:getEntityById(part.Parent.Name)
                if hitEntity and hitEntity.collider then
                    collider.hitEntity = hitEntity
                end
            end
        end)
        Sunshine:addConnection(model.model.PrimaryPart.TouchEnded, function(part)
            if part.Parent and part.Parent:IsA("Model") and part.Parent.PrimaryPart == part then
                local hitEntity = Sunshine:getEntityById(part.Parent.Name)
                if hitEntity and hitEntity.collider then
                    collider.hitEntity = nil
                end
            end
        end)
    end
end