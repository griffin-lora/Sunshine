--this is incredibly hacky

local CollectionService = game:GetService("CollectionService")

return function(Sunshine, entity)
    local water = entity.water
    local model = entity.model
    local transform = entity.transform
    local collider = entity.collider
    if water and collider and model and transform then
        local character
        Sunshine:update(function()
            local touchedEntity
            for _,hitEntity in pairs(collider.hitEntities) do
                if hitEntity and hitEntity.hydrophobic and hitEntity.health then
                    hitEntity.health.health = 0
                elseif hitEntity and hitEntity.character and hitEntity.character.controllable
                then
                    character = hitEntity
                    character.character.swimming = true
                    touchedEntity = true
                end
            end
            if character and not touchedEntity then
                character.character.swimming = false
                character = nil
            end
        end, entity)
    end
end