local CollectionService = game:GetService("CollectionService")

return function(Sunshine, entity)
    local checkpoint = entity.checkpoint
    local spawn = entity.spawn
    local collider = entity.collider
    local model = entity.model
    if checkpoint and spawn and collider and model then
        Sunshine:update(function()
            if collider.hitEntity and collider.hitEntity.character and collider.hitEntity.character.controllable then
                spawn.active = true
            end
            for _, descendant in pairs(model.model:GetDescendants()) do
                if CollectionService:HasTag(descendant, "flag") then
                    if spawn.active then
                        descendant.Color = Color3.fromRGB(196, 40, 28)
                    else
                        descendant.Color = Color3.fromRGB(0, 0, 0)
                    end
                end
            end
        end, entity)
    end
end