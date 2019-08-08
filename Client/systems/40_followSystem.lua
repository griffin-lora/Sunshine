local VECTOR3_NEW = Vector3.new
local BLANK_VECTOR3 = VECTOR3_NEW()

return function(Sunshine, entity)
    local follow = entity.follow
    local model = entity.model
    local transform = entity.transform
    local character = entity.character
    if follow and model and transform and character then
        Sunshine:update(function()
            local player
            for _, otherEntity in pairs(entity.core.scene.entities) do
                if otherEntity.tag and otherEntity.tag.tag == "player" then
                    player = otherEntity
                    break
                end
            end
            local mainCharacter = Sunshine:getEntity(player.player.character, entity.core.scene)
            if not character.controllable and follow.active then
                character.moveVector = BLANK_VECTOR3
                local tip = transform.cFrame.Position
                local direction = transform.cFrame.LookVector.Unit
                local height = follow.range
                local position = mainCharacter.transform.cFrame.Position
                local coneDistance = (position - tip):Dot(direction)
                if 0 <= coneDistance and coneDistance <= height then
                    local coneRadius = (coneDistance / height) * follow.radius
                    local orthogonalDistance = ((position - tip) - coneDistance * direction).Magnitude
                    if orthogonalDistance < coneRadius then
                        if not Sunshine:findPartOnRay(Ray.new(transform.cFrame.Position,
                        direction), {model.model, mainCharacter.model.model}) then
                            local lookDirection = mainCharacter.transform.cFrame.Position - transform.cFrame.Position
                            local moveVector = VECTOR3_NEW(lookDirection.X, 0, lookDirection.Z).Unit
                            if moveVector.Unit.Magnitude == moveVector.Unit.Magnitude then
                                character.moveVector = moveVector
                            end
                        end
                    end
                end
            else
                character.moveVector = nil
            end
        end, entity)
    end
end