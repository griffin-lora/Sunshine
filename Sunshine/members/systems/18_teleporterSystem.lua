-- TrafficConeGod

return function(Sunshine, entity)
    local teleporter = entity.teleporter
    local collider = entity.collider
    local button = entity.button
    if teleporter then
        local scene = require(teleporter.scene)
        if collider then
            Sunshine:update(function()
                if collider.hitEntity and collider.hitEntity.tag and collider.hitEntity.tag.tag == "character" then
                    Sunshine:loadScene(scene)
                end
            end)
        elseif button then
            Sunshine:update(function()
                if button.activated then
                    Sunshine:loadScene(scene)
                end
            end)
        end
    end
end