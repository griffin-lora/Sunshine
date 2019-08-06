local CollectionService = game:GetService("CollectionService")

return function(Sunshine, entity)
    local sup = entity.swingingUprightPlatform --hi
    local model = entity.model
    local transform = entity.transform
    local rotation = 0

    if sup and model then
        local oldRotation = transform.cFrame - transform.cFrame.Position
        Sunshine:update(function()
            transform.cFrame = CFrame.new(transform.cFrame.Position) * CFrame.Angles(math.rad(rotation), oldRotation.Y,
            oldRotation.Z)
            ----------------------------
            rotation = math.sin(entity.core.tick * sup.speed) * sup.range
            ----------------------------
            for _, descendant in pairs(model.model:GetDescendants()) do
                if CollectionService:HasTag(descendant, "uprightPlatform") then
                    local _, y, z = descendant.CFrame:toEulerAnglesXYZ()
                    descendant.CFrame = CFrame.new(descendant.Position) * CFrame.Angles(0, y, z)
                end
            end
        end, entity)
    end
end