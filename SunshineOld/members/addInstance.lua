return function(Sunshine, instance, entity)
    if not entity then
        error("addInstance is being used without entity specification.")
    end
    Sunshine.instances[#Sunshine.instances + 1] = {instance, entity}
end