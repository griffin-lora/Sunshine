-- TrafficConeGod

local cameraInstance = workspace.Camera

return function(Sunshine, entity, scene)
    local camera = entity.camera
    local transform = entity.transform
    if camera and transform then
        cameraInstance.CFrame = transform.cFrame
        Sunshine:update(function()
            local subject = Sunshine:getEntity(camera.subject, scene)
            if subject and subject.model and camera.controllable then
                cameraInstance.CameraType = Enum.CameraType.Custom
                cameraInstance.CameraSubject = subject.model.model
            end
            if not camera.controllable then
                cameraInstance.CameraType = Enum.CameraType.Scriptable
            end
            transform.cFrame = cameraInstance.CFrame
            cameraInstance.FieldOfView = camera.fieldOfView
        end, entity)
    end
end