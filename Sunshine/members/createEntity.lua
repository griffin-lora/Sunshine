return function(Sunshine, entity)
    entity = Sunshine:copyTable(entity)
    Sunshine.scene.entities[#Sunshine.scene.entities + 1] = entity
    for _, system in ipairs(Sunshine.callOrder) do
        system(Sunshine, entity)
    end
end