-- TrafficConeGod

local charPosition = Vector3.new()
local DEFAULT_PAUSE_DISTANCE = 250

return function(Sunshine, entity)
    local core = entity.core
    local model = entity.model
    local transform = entity.transform
    local transparency = entity.transparency
    local distancePause = entity.distancePause
    local character = entity.character
    local originalSize
    local lastResult
    local wasActive

    if model and transform then
        wasActive = entity.core.active
        model.model = model.model:Clone()
        Sunshine:addInstance(model.model, entity)
        model.model.Name = entity.core.id
        model.model:SetPrimaryPartCFrame(transform.cFrame)
        model.model.Parent = workspace
        -- local lastSize = Vector3.new(1, 1, 1)
        -- local originalCFrames = {}
        -- for _, descendant in pairs(model.model:GetDescendants()) do
        --     if descendant:IsA("BasePart") then
        --         originalCFrames[descendant] = descendant.CFrame
        --     end
        -- end
        originalSize = model.model.PrimaryPart.Size
        transform.cFrame = nil
        local lastCFrame = CFrame.new()
        setmetatable(transform, {
            __index = function(_, key)
                if not model.model.Parent then
                    setmetatable(transform, {})
                    transform.cFrame = CFrame.new()
                    return lastCFrame
                end
                if key == "cFrame" then
                    lastCFrame = model.model:GetPrimaryPartCFrame()
                    return lastCFrame
                end
            end,
            __newindex = function(_, key, value)
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
    end
    Sunshine:update(function()
        if character and transform then
            if character.controllable then
                charPosition = transform.cFrame.Position
            end
        end
        if model and transform then
            if model.model.PrimaryPart and transparency or transform.size ~= Vector3.new(1, 1, 1) then
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
            if wasActive then
                local distance = DEFAULT_PAUSE_DISTANCE
                local disabled = false
                local stop = false

                if distancePause then
                    distance = distancePause.distance
                    disabled = distancePause.disabled
                end
                if character then
                    if character.controllable then
                        disabled = true
                    end
                end
                if entity.head then
                    disabled = true
                end
                for _,otherEntity in pairs(entity.core.scene.entities) do
                    if otherEntity.scriptCollectible then
                        if otherEntity.scriptCollectible.active == true then
                            stop = true
                        end
                    end
                    if otherEntity.key then
                        if otherEntity.key.active then
                            stop = true
                        end
                    end
                end

                if not stop then
                    if (transform.cFrame.Position - charPosition).Magnitude > distance and not disabled then
                        entity.core.active = false
                        lastResult = false
                    else
                        if lastResult == entity.core.active then
                            entity.core.active = true
                        end
                        lastResult = true
                    end
                end
            end
        end
    end, entity, true)
end