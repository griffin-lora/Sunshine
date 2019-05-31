-- TrafficConeGod

return function(Sunshine, entity)
    local frame = entity.frame
    local uiTransform = entity.uiTransform
    if frame and uiTransform then
        frame.frame = frame.frame:Clone()
        Sunshine:addInstance(frame)
        Sunshine:update(function()
            
        end)
    end
end