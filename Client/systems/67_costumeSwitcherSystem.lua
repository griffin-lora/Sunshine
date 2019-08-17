--EXTREMELY temporary
--I'd use CollectionService tags but this is really temporary

local CollectionService = game:GetService("CollectionService")
local UserInputService = game:GetService("UserInputService")
local costumeFolder = game:GetService("ReplicatedStorage").Assets.costumes
local numKeys = {
    [0] = Enum.KeyCode.Zero,
    [1] = Enum.KeyCode.One,
    [2] = Enum.KeyCode.Two,
    [3] = Enum.KeyCode.Three,
    [4] = Enum.KeyCode.Four,
    [5] = Enum.KeyCode.Five,
    [6] = Enum.KeyCode.Six,
    [7] = Enum.KeyCode.Seven,
    [8] = Enum.KeyCode.Eight,
    [9] = Enum.KeyCode.Nine,
}
local selectedNum = 1

return function(Sunshine, entity)
    local costumeChanger = entity.costumeChanger
    local model = entity.model

    if costumeChanger and model then
        local folderInstance
        Sunshine:addConnection(UserInputService.InputBegan, function(input, gameProcessedEvent)
            if not gameProcessedEvent then
                if input.KeyCode == Enum.KeyCode.Left or input.KeyCode == Enum.KeyCode.DPadLeft then
                    selectedNum = selectedNum - 1
                    if selectedNum < 0 then
                        selectedNum = 9
                    end
                elseif input.KeyCode == Enum.KeyCode.Right or input.KeyCode == Enum.KeyCode.DPadRight then
                    selectedNum = selectedNum + 1
                    if selectedNum > 9 then
                        selectedNum = 0
                    end
                end
                for _, costume in pairs(costumeFolder:GetChildren()) do
                    local selected = false
                    if input.KeyCode == numKeys[costume.NumberKey.Value] then
                        selected = true
                    elseif input.KeyCode == Enum.KeyCode.Left or input.KeyCode == Enum.KeyCode.DPadLeft or input.KeyCode == Enum.KeyCode.Right or input.KeyCode == Enum.KeyCode.DPadRight then
                        if selectedNum == costume.NumberKey.Value then
                            selected = true  
                        end
                    end
                    if selected then
                        if not model.model:FindFirstChild("costumeWelds") then
                            folderInstance = Instance.new("Folder")
                            folderInstance.Name = "costumeWelds"
                            folderInstance.Parent = model.model
                        else
                            model.model.costumeWelds:ClearAllChildren()
                        end
                        for _, child in pairs(costume:GetChildren()) do
                            if child:IsA("Model") then
                                if model.model:FindFirstChild(child.Name) then
                                    local costumePart = child:Clone()
                                    costumePart:SetPrimaryPartCFrame(model.model[child.Name].CFrame)
                                    local bodyWeld = Instance.new("WeldConstraint")
                                    local ppWeld = Instance.new("WeldConstraint")
                                    ppWeld.Part0 = costumePart.Display
                                    ppWeld.Part1 = costumePart.PrimaryPart
                                    ppWeld.Parent = costumePart
                                    bodyWeld.Part0 = costumePart.PrimaryPart
                                    bodyWeld.Part1 = model.model[child.Name]
                                    bodyWeld.Parent = costumePart
                                    costumePart.Parent = folderInstance
                                    if child.Name == "Head" then
                                        CollectionService:AddTag(costumePart.Display, "head")
                                    end
                                end
                            end
                        end
                        for _, bodyPart in pairs(model.model:GetChildren()) do
                            if bodyPart:IsA("MeshPart") then
                                bodyPart.TextureID = "rbxassetid://"..costume.ClothesImage.Value
                            end
                        end
                        costumeChanger.currentCostume = costume.Name
                    end
                end
            end
        end, entity)
    end
end