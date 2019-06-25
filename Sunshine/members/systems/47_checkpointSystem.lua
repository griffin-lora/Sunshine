local CollectionService = game:GetService("CollectionService")

return function(Sunshine, entity)
    local checkpoint = entity.checkpoint
    local spawn = entity.spawn
    local collider = entity.collider
    local model = entity.model
    if checkpoint and spawn and collider and model then
        local last = false
        Sunshine:update(function()
            for _, descendant in pairs(model.model:GetDescendants()) do
                if CollectionService:HasTag(descendant, "flag") then
                    if spawn.active then
                        descendant.Transparency = 1
                    else
                        descendant.Transparency = 0
                    end
                end
            end
            if collider.hitEntity and collider.hitEntity.character and collider.hitEntity.character.controllable then
                print(spawn.active ~= last)
                last = spawn.active
                spawn.active = true
            end
        end, true)
    end
end