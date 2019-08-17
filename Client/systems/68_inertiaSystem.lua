return function(Sunshine, entity)
    local inertia = entity.inertia
    local transform = entity.transform
    local collider = entity.collider
    if inertia and transform and collider then
        local lastCFrame
        Sunshine:update(function()
            if #collider.hitEntities > 1 then
                local difference = lastCFrame.Position - transform.cFrame.Position
                for _, hitEntity in pairs(collider.hitEntities) do
                    if hitEntity.character and hitEntity.transform then
                        hitEntity.transform.cFrame = hitEntity.transform.cFrame + difference
                    end
                end
            end
            lastCFrame = transform.cFrame
        end, entity)
    end
end