local CollectionService = game:GetService("CollectionService")

return function(Sunshine, entity)
    local magicMirror = entity.magicMirror
    local teleporter = entity.teleporter
    local model = entity.model
    local store = entity.store
    if magicMirror and teleporter and store then
        local loaded = false
        for _, descendant in pairs(model.model:GetDescendants()) do
            if CollectionService:HasTag(descendant, "preview") then
                descendant.Texture = "rbxassetid://" .. magicMirror.preview
            end
        end
        Sunshine:update(function()
            if store.save and not loaded then
                entity.magicMirror = store.save.magicMirror or magicMirror
                magicMirror = entity.magicMirror
                store.save.magicMirror = magicMirror
                loaded = true
                for _, descendant in pairs(model.model:GetDescendants()) do
                    if CollectionService:HasTag(descendant, "preview") then
                        if magicMirror.active then
                            descendant.Transparency = 0
                        else
                            descendant.Transparency = 1
                        end
                    end
                end
            end
            if store.save then
                if teleporter.activated then
                    magicMirror.active = true
                end
            end
        end, entity)
    end
end