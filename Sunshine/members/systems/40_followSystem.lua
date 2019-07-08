return function(Sunshine, entity, scene)
    local follow = entity.follow
    local model = entity.model
    local transform = entity.transform
    local character = entity.character
    if follow and model and transform and character then
        Sunshine:update(function()
            local player
            for _, otherEntity in pairs(scene.entities) do
                if otherEntity.tag and otherEntity.tag.tag == "player" then
                    player = otherEntity
                    break
                end
            end
            local mainCharacter = Sunshine:getEntity(player.player.character, scene)
            if not character.controllable and follow.active then
                character.moveVector = Vector3.new()
                local direction = mainCharacter.transform.cFrame.Position - transform.cFrame.Position
                if direction.Magnitude < follow.range and not Sunshine:findPartOnRay(Ray.new(transform.cFrame.Position,
                direction), {model.model, mainCharacter.model.model}) then
                    local moveVector = Vector3.new(direction.X, 0, direction.Z).Unit
                    if moveVector.Unit.Magnitude == moveVector.Unit.Magnitude then
                        character.moveVector = moveVector
                    end
                end
            else
                character.moveVector = nil
            end
        end, entity)
    end
end