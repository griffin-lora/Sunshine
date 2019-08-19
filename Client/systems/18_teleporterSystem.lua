-- TrafficConeGod

return function(Sunshine, entity)
    local teleporter = entity.teleporter
    local collider = entity.collider
    local button = entity.button
    if teleporter then
        local scene = require(teleporter.scene)
        if collider then
            Sunshine:update(function()
                if collider.hitEntity and collider.hitEntity.character and
                collider.hitEntity.character.controllable then
                    teleporter.activated = true
                    local cutout
                    for _, otherEntity in pairs(Sunshine.scenes[2].entities) do
                        if otherEntity.tag and otherEntity.tag.tag == "sceneTransition" then
                            cutout = otherEntity
                            break
                        end
                    end
                    cutout.sceneTransition.scene = scene
                    cutout.sceneTransition.type = "teleport"
                    cutout.sceneTransition.loading = true
                end
            end, entity)
        elseif button then
            Sunshine:update(function()
                if button.activated then
                    teleporter.activated = true
                    local cutout
                    for _, otherEntity in pairs(Sunshine.scenes[2].entities) do
                        if otherEntity.tag and otherEntity.tag.tag == "sceneTransition" then
                            cutout = otherEntity
                            break
                        end
                    end
                    cutout.sceneTransition.scene = scene
                    cutout.sceneTransition.type = "teleport"
                    cutout.sceneTransition.loading = true
                end
            end, entity)
        end
    end
end