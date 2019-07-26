return function(Sunshine, entity, state, startCheck, start, update, stopCheck, stop, generalUpdate)
    local component = entity[state]
    local character = entity.character
    local input = entity.input
    local transform = entity.transform
    local physics = entity.physics
    local animator = entity.animator
    if component and character and transform and input and physics and animator then
        local lastState = character.state
        Sunshine:update(function(step)
            if character.controllable then
                if lastState ~= state and character.state == state then
                    start(step)
                elseif character.state == state then
                    update(step)
                    if stopCheck(step) then
                        stop(step)
                        character.state = nil
                    end
                elseif startCheck(step) then
                    character.state = state
                    start(step)
                end
                if lastState == state and character.state ~= state then
                    stop(step)
                end
            end
            if generalUpdate then
                generalUpdate(step)
            end
            lastState = character.state
        end, entity)
    end
end