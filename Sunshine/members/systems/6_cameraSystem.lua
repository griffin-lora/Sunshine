-- TrafficConeGod

local cameraInstance = workspace.Camera

return function(Sunshine, entity)
    local camera = entity.camera
    local transform = entity.transform
    if camera and transform then
        cameraInstance.CameraType = Enum.CameraType.Custom
        Sunshine:update(function()
            local subject = Sunshine:getEntityById(camera.subject)
            if subject and subject.model then
                cameraInstance.CameraSubject = subject.model.model
            end
            transform.cFrame = cameraInstance.CFrame
            cameraInstance.FieldOfView = camera.fieldOfView
        end)
    end
end