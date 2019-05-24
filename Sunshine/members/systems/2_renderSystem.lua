return function(Sunshine, entity)
    local model = entity.model
    local transform = entity.transform
    local physics = entity.physics
    if model and transform then
        model.model = model.model:Clone()
        Sunshine:addInstance(model.model)
        model.model.Name = entity.core.id
        model.model:SetPrimaryPartCFrame(transform.cFrame)
        model.model.Parent = workspace
        local lastSize = Vector3.new(1, 1, 1)
        local originalCFrames = {}
        for index, descendant in pairs(model.model:GetDescendants()) do
            if descendant:IsA("BasePart") then
                originalCFrames[descendant] = descendant.CFrame
            end
        end
        transform.cFrame = nil
        setmetatable(transform, {
            __index = function(self, key)
                if key == "cFrame" then
                    return model.model:GetPrimaryPartCFrame()
                end
            end,
            __newindex = function(self, key, value)
                if key == "cFrame" then
                    model.model:SetPrimaryPartCFrame(value)
                end
            end
        })
        Sunshine:update(function()
            for index, descendant in pairs(model.model:GetDescendants()) do
                if descendant:IsA("BasePart") then
                    descendant.Size = descendant.Size / lastSize
                    descendant.Size = descendant.Size * transform.size
                end
            end
            lastSize = transform.size
        end)
    end
end