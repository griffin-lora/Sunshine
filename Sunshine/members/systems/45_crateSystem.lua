return function(Sunshine, entity)
    local collider = entity.collider
    local transparency = entity.transparency
    local crate = entity.crate
    if crate and collider and transparency then
        Sunshine:update(function()
            if collider.hitEntity and collider.hitEntity.head and transparency.transparency ~= 1 then
                transparency.transparency = 1
                print("ded")
                if crate.spawnEntity then
                    print("spawn")
                end
            end
        end, entity)
    end
end