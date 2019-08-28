local CollectionService = game:GetService("CollectionService")
local state = "throw"
local costumeFolder = game:GetService("ReplicatedStorage").Assets.costumes

return function(Sunshine, entity)
    local component = entity[state]
    local character = entity.character
    local costumeChanger = entity.costumeChanger
    local input = entity.input
    local transform = entity.transform
    local physics = entity.physics
    local animator = entity.animator
    local speaker = entity.speaker
    local model = entity.model
    local lastE = false
    local head = {core = {}}
    local cFrame
    local lastActive
    Sunshine:createStateSystem(entity, state, function()
        -- start check
        return not head.core.active and character.state ~= "groundPound" and character.state ~= "crouch" and character.state ~= "bonk" and character.state ~= "dive" and input.e and
        not lastE
    end, function()
        -- start
        local dataScene = Sunshine.dataScenes[entity.core.scene.index]
        if Sunshine:getEntity(component.head, dataScene) then
            cFrame = CFrame.new(transform.cFrame.Position + (transform.cFrame.LookVector.Unit * component.distance))
            local headClone = Sunshine:cloneTable(Sunshine:getEntity(component.head, dataScene))
            headClone.core.active = true
            head = Sunshine:createEntity(headClone, entity.core.scene)
        end
        local velocityY
        if character.grounded then
            velocityY = physics.velocity.Y
        else
            velocityY = component.power
        end
        character.canLoseMagnitude = true
        physics.velocity = Vector3.new(physics.velocity.X * 0.1, velocityY, physics.velocity.Z * 0.1)
        if animator.action == component.animation then
            animator.action = nil
        else
            animator.action = component.animation
            if component.sound then
                speaker.id = component.sound
                speaker.playing = true
            end
        end
    end, function()
        -- update
        head.head.cFrame = cFrame
        character.canLoseMagnitude = false
        if not animator.action then
            animator.action = component.animation
        end
    end, function()
        -- end check
        return character.grounded
    end, function()
        -- end
    end, function()
        -- general update
        lastE = input.e
        local folderInstance
        if head.core.active and costumeChanger then
            if not lastActive then
                local costume = costumeFolder:FindFirstChild(costumeChanger.currentCostume)
                local folder = head.model.model:FindFirstChild("costumeWelds")
                if not folder then
                    folderInstance = Instance.new("Folder")
                    folderInstance.Name = "costumeWelds"
                    folderInstance.Parent = head.model.model
                else
                    folder:ClearAllChildren()
                end
                if costume then
                    if costume:FindFirstChild("Head") then
                        local hat = costume.Head:Clone()
                        hat:SetPrimaryPartCFrame(head.transform.cFrame)
                        local headWeld = Instance.new("WeldConstraint")
                        local ppWeld = Instance.new("WeldConstraint")
                        ppWeld.Part0 = hat.Display
                        ppWeld.Part1 = hat.PrimaryPart
                        ppWeld.Parent = hat
                        headWeld.Part0 = hat.PrimaryPart
                        headWeld.Part1 = head.model.model.Head
                        headWeld.Parent = hat
                        hat.Parent = folderInstance
                    end
                end
            end
        end
        for _, descendant in pairs(model.model:GetDescendants()) do
            if CollectionService:HasTag(descendant, "head") then
                if head.core.active then
                    descendant.Transparency = 1
                    CollectionService:RemoveTag(descendant, "flashable")
                else
                    local transparency = 0
                    if CollectionService:HasTag(descendant, "translucent") then
                        transparency = 0.5
                    end
                    descendant.Transparency = transparency
                    CollectionService:AddTag(descendant, "flashable")
                end
            elseif CollectionService:HasTag(descendant, "playerGem") then
                if head.core.active then
                    descendant.Color = Color3.fromRGB(0, 255, 0)
                    descendant.Material = Enum.Material.Neon
                else
                    descendant.Color = Color3.fromRGB(6, 103, 0)
                    descendant.Material = Enum.Material.SmoothPlastic
                end
            end
        end
        lastActive = head.core.active
    end)
end