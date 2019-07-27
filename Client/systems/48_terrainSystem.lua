local Terrain = workspace.Terrain

return function(Sunshine, entity)
    local terrain = entity.terrain
    local transform = entity.transform
    local water = entity.water 
    if terrain and transform and not water then --another hack
        Terrain:FillBlock(transform.cFrame, transform.size, Enum.Material.Water)
        Sunshine:entityDestroy(function()
            Terrain:FillBlock(transform.cFrame, transform.size, Enum.Material.Air)
        end, entity)
    end
end