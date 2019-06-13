return function(Sunshine, entity)
    local capture = entity.capture
    local character = entity.character
    local input = entity.input
    if capture and character and input then
        Sunshine:update(function()
            if capture.active then
                if input.shift then
                    capture.active = false
                    Sunshine:getEntityById(capture.character).character.controllable = true
                    character.controllable = false
                end
            end
        end, entity)
    end
end