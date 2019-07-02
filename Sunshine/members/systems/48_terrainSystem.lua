local Terrain = workspace.Terrain

return function(Sunshine, entity)
    local terrain = entity.terrain
    local transform = entity.transform
    if terrain and transform then
        Terrain:FillBlock(transform.cFrame, transform.size, Enum.Material.Water)
        Sunshine:entityDestroy(function()
            print("i die")
            Terrain:FillBlock(transform.cFrame, transform.size, Enum.Material.Air)
        end, entity)
    end
end