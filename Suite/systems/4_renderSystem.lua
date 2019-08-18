-- TrafficConeGod

return function(Sunshine, entity)
    local model = entity.model
    local transform = entity.transform
    local transparency = entity.transparency
    if model and transform then
        local changeManager
        local lastModel
        local modelInstance
        local name = model.model.Name
        local parent = model.model.Parent
        -- local lastSize = Vector3.new(1, 1, 1)
        -- local originalCFrames = {}
        -- for _, descendant in pairs(modelInstance:GetDescendants()) do
        --     if descendant:IsA("BasePart") then
        --         originalCFrames[descendant] = descendant.CFrame
        --     end
        -- end
        -- local originalSize
        transform.cFrame = nil
        local lastCFrame = CFrame.new()
        setmetatable(transform, {
            __index = function(_, key)
                if not modelInstance.Parent then
                    setmetatable(transform, {})
                    transform.cFrame = CFrame.new()
                    return lastCFrame
                end
                if modelInstance and key == "cFrame" then
                    lastCFrame = modelInstance:GetPrimaryPartCFrame()
                    return lastCFrame
                end
            end,
            __newindex = function(_, key, value)
                if not modelInstance.Parent then
                    setmetatable(transform, {})
                    return
                end
                if modelInstance and key == "cFrame" then
                    if value.LookVector.Unit.Magnitude == value.LookVector.Unit.Magnitude then
                        modelInstance:SetPrimaryPartCFrame(value)
                    end
                end
            end
        })
        local previousCFrame
        local startTick = entity.core.tick
        local changed = false
        Sunshine:update(function()
            if model.model and lastModel ~= model.model then
                if not model.model.PrimaryPart then
                    error(model.model:GetFullName())
                end
                if modelInstance then
                    modelInstance:Destroy()
                end
                modelInstance = model.model:Clone()
                Sunshine:addInstance(modelInstance, entity)
                modelInstance.Name = entity.core.name
                modelInstance:SetPrimaryPartCFrame(transform.cFrame)
                for _, descendant in pairs(modelInstance:GetDescendants()) do
                    Sunshine:addConnection(descendant.Changed, function()
                        changed = true
                    end, entity)
                end
                modelInstance.Parent = Sunshine.workspace
                -- originalSize = m odelInstance.PrimaryPart.Size
            end
            lastModel = model.model
            if entity.core.tick - startTick > 3 and changed then
                changed = false
                startTick = entity.core.tick
                local modelInstanceClone = modelInstance:Clone()
                modelInstanceClone.Name = name
                modelInstanceClone.Parent = parent
                model.model:Destroy()
                changeManager.change.entity = entity
                changeManager.change.componentName = "model"
                changeManager.change.propertyName = "model"
                changeManager.change.propertyValue = modelInstanceClone
                changeManager.change.alreadyChangedOnEntity = true
                lastModel = model.model
            end
            if not changeManager then
                for _, otherEntity in pairs(Sunshine.scenes[1].entities) do
                    if otherEntity.tag and otherEntity.tag.tag == "changeManager" then
                        changeManager = otherEntity
                        break
                    end
                end
            end
            if modelInstance and changeManager and modelInstance.PrimaryPart then
                local cFrame = modelInstance:GetPrimaryPartCFrame()
                if previousCFrame and previousCFrame ~= cFrame and not changeManager.change.teamCreateUpdate then
                    changeManager.change.entity = entity
                    changeManager.change.componentName = "transform"
                    changeManager.change.propertyName = "cFrame"
                    changeManager.change.propertyValue = cFrame
                    changeManager.change.alreadyChangedOnEntity = true
                end
                previousCFrame = cFrame
            end
            if modelInstance and (modelInstance.PrimaryPart and transparency or transform.size ~= Vector3.new(1, 1, 1)) then
                -- modelInstance.PrimaryPart.Size = originalSize * transform.size
                local descendants = modelInstance:GetDescendants()
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
        end, entity)
    end
end