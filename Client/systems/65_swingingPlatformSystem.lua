local CollectionService = game:GetService("CollectionService")

return function(Sunshine, entity)
    local sup = entity.swingingUprightPlatform --hi
    local model = entity.model
    local transform = entity.transform
    local rotation = 0
    local reverse = false

    if sup and model then
        local oldRotation = transform.cFrame - transform.cFrame.Position
        Sunshine:update(function()
            transform.cFrame = CFrame.new(transform.cFrame.Position) * CFrame.Angles(math.rad(rotation),oldRotation.Y,oldRotation.Z)
            ----------------------------
            if rotation > sup.range then
                reverse = true
            elseif rotation < -sup.range then
                reverse = false
            end
            rotation = reverse and rotation - sup.speed or rotation + sup.speed
            ----------------------------
            for _,p in pairs(model.model:GetDescendants()) do
                if CollectionService:HasTag(p, "uprightPlatform") then
                    local x, y, z = p.CFrame:toEulerAnglesXYZ()
                    p.CFrame = CFrame.new(p.Position) * CFrame.Angles(0,y,z)
                end
            end
        end, entity)
    end
end