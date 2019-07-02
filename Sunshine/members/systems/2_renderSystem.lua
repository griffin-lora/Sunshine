-- TrafficConeGod

return function(Sunshine, entity)
    local model = entity.model
    local transform = entity.transform
    local transparency = entity.transparency
    if model and transform then
        model.model = model.model:Clone()
        Sunshine:addInstance(model.model, entity)
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
        local originalSize = model.model.PrimaryPart.Size
        transform.cFrame = nil
        setmetatable(transform, {
            __index = function(self, key)
                if not model.model.Parent then
                    setmetatable(transform, {})
                    return CFrame.new()
                end
                if key == "cFrame" then
                    return model.model:GetPrimaryPartCFrame()
                end
            end,
            __newindex = function(self, key, value)
                if not model.model.Parent then
                    setmetatable(transform, {})
                    return
                end
                if key == "cFrame" then
                    if value.LookVector.Unit.Magnitude == value.LookVector.Unit.Magnitude then
                        model.model:SetPrimaryPartCFrame(value)
                    else
                        warn("A transformation error occurred. Input CFrame is: " .. tostring(value))
                    end
                end
            end
        })
        Sunshine:update(function()
            if transparency or transform.size ~= Vector3.new(1, 1, 1) then
                model.model.PrimaryPart.Size = originalSize * transform.size
                local descendants = model.model:GetDescendants()
                for index = 1, #descendants do
                    local descendant = descendants[index]
                    if descendant:IsA("BasePart") then
                        -- descendant.Size = descendant.Size / lastSize
                        -- descendant.Size = descendant.Size * transform.size
                        if transparency then
                            descendant.Transparency = transparency.transparency
                        end
                    elseif descendant:IsA("ParticleEmitter") or descendant:IsA("PointLight") then
                        if transparency then
                            if transparency.transparency == 1 then
                                descendant.Enabled = false
                            elseif transparency.transparency == 0 then
                                descendant.Enabled = true
                            end
                        end
                    end
                end
            end
            lastSize = transform.size
        end, entity)
    end
end