return function(Sunshine, entity)
    local teleporter = entity.teleporter
    local collider = entity.collider
    if teleporter and collider then
        local scene = require(teleporter.scene)
        Sunshine:update(function()
            Sunshine:loadScene(scene)
        end)
    end
end