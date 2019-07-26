local CollectionService = game:GetService("CollectionService")
local state = "dash"

return function(Sunshine, entity)
    local component = entity[state]
    local character = entity.character
    local input = entity.input
    local animator = entity.animator
    local model = entity.model
    local lastE = false
    local startTick
    Sunshine:createStateSystem(entity, state, function()
        -- start check
        return startTick and entity.core.tick - startTick >= component.time
    end, function()
        -- start
        character.walkSpeedFactor = component.factor
        startTick = nil
        animator.action = component.animation
    end, function()
        -- update
    end, function()
        -- end check
        return not input.e or not character.moving
    end, function()
        -- end
        character.walkSpeedFactor = 1
        animator.action = nil
    end, function()
        -- general update
        if character.state ~= state then
            if input.e and not lastE then
                startTick = entity.core.tick
            elseif not input.e then
                startTick = nil
            end
        end
        lastE = input.e
        for _, descendant in pairs(model.model:GetDescendants()) do
            if CollectionService:HasTag(descendant, "dash") then
                descendant.Enabled = character.state == state
            end
        end
    end)
end