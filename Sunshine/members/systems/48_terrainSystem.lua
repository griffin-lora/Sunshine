local Terrain = workspace.Terrain

return function(Sunshine, entity)
    local terrain = entity.terrain
    local transform = entity.transform
    if terrain and transform then
        Terrain:FillBlock(transform.cFrame, transform.size, Enum.Material.Grass)
    end
end