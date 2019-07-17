return function(Sunshine, entity)
    local music = entity.music
    local sound = entity.sound
    if music and sound then
        -- local loading = false
        -- Sunshine:entityDestroy(function(destroy)
        --     loading = true
        --     print(destroy)
        --     return destroy
        -- end, entity)
        -- Sunshine:update(function()
        --     -- print("iexist",entity.core.id)
        --     -- if loading and Sunshine.scene and Sunshine.scene.entities then
        --     --     for _, otherEntity in pairs(Sunshine.scene.entities) do
        --     --         -- print(otherEntity ~= entity, otherEntity.music)
        --     --         if otherEntity ~= entity and otherEntity.sound and otherEntity.sound.id == sound.id then
        --     --             Sunshine:destroyEntity(otherEntity, false)
        --     --             loading = false
        --     --             break
        --     --         end
        --     --     end
        --     --     if loading then
        --     --         -- print("d")
        --     --         Sunshine:destroyEntity(entity, false)
        --     --     end
        --     -- end
        -- end, entity)
    end
end