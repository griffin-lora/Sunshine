--this is incredibly hacky

local CollectionService = game:GetService("CollectionService")

return function(Sunshine, entity)
    local water = entity.water
    local model = entity.model
    local transform = entity.transform
    local collider = entity.collider
    if water and collider and model and transform then
        local character
        for _,p in pairs(model.model:GetDescendants()) do
            if CollectionService:HasTag(p, "waterBottom") then
                p.Size = transform.size
            elseif CollectionService:HasTag(p, "forcefield") then
                p.Size = Vector3.new(transform.size.X,0.05,transform.size.Z)
                p.CFrame = CFrame.new(transform.cFrame.Position + Vector3.new(0,transform.size.Y/2,0))
            end
        end
        Sunshine:update(function()
            if collider.hitEntity and collider.hitEntity.hydrophobic and collider.hitEntity.health then
                collider.hitEntity.health.health = 0
            elseif collider.hitEntity and collider.hitEntity.character and collider.hitEntity.character.controllable
            then
                character = collider.hitEntity
                character.character.swimming = true
            elseif character then
                character.character.swimming = false
                character = nil
            end
            for _,p in pairs(model.model:GetDescendants()) do
                if CollectionService:HasTag(p, "waterTexture") then
                    p.OffsetStudsU = p.OffsetStudsU + .1
                    p.OffsetStudsV = p.OffsetStudsV + .1
                end
            end
        end, entity)
    end
    Sunshine:apologize()
end