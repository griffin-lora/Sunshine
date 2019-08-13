local CollectionService = game:GetService("CollectionService")

return function(Sunshine, entity)
    local textureScroller = entity.textureScroller
    local model = entity.model

    if textureScroller and model then
        Sunshine:update(function()
            for _, descendant in pairs(model.model:GetDescendants()) do
                if CollectionService:HasTag(descendant, "scrollable") then
                    descendant.OffsetStudsU = descendant.OffsetStudsU + textureScroller.incrementU
                    descendant.OffsetStudsV = descendant.OffsetStudsV + textureScroller.incrementV
                end
            end
        end, entity)
    end
end