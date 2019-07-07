-- TrafficConeGod

local UserInputService = game:GetService("UserInputService")
local Camera = workspace.Camera

return function(Sunshine, entity, scene)
    local camera = entity.camera
    local transform = entity.transform
    if camera and transform then
        local zoom = 15
        local yaw = -30
        local pitch = 0
        local mouseDown = false
        local mouseScrollWheel = 0
        local mouseChange = Vector3.new()
        local function handleInput(inputObject)
            if inputObject.UserInputType == Enum.UserInputType.MouseWheel then
                mouseScrollWheel = inputObject.Position.Z
            elseif inputObject.UserInputType == Enum.UserInputType.MouseButton2 then
                mouseDown = inputObject.UserInputState == Enum.UserInputState.Begin
            elseif inputObject.UserInputType == Enum.UserInputType.MouseMovement then
                mouseChange = inputObject.Delta
            end
        end
        Sunshine:addConnection(UserInputService.InputBegan, handleInput, entity, true)
        Sunshine:addConnection(UserInputService.InputChanged, handleInput, entity, true)
        Sunshine:addConnection(UserInputService.InputEnded, handleInput, entity, true)
        Sunshine:update(function(step)
            local subject = Sunshine:getEntity(camera.subject, scene)
            if subject and camera.controllable then
                zoom = zoom - (mouseScrollWheel * camera.scrollSpeed)
                zoom = math.clamp(zoom, camera.minZoom, camera.maxZoom)
                if mouseDown then
                    yaw = yaw - (mouseChange.Y * camera.rotateSpeed)
                    yaw = math.clamp(yaw, -80, 80)
                    pitch = pitch - (mouseChange.X * camera.rotateSpeed)
                end
                local hackPart = Instance.new("Part") -- This is hacky code 101. But euler angles work differently and
                -- I can't be bothered to look up the math to do it.
                hackPart.Orientation = Vector3.new(yaw, pitch, 0)
                local cFrame = CFrame.new(subject.transform.cFrame.Position, subject.transform.cFrame.Position
                + hackPart.CFrame.LookVector)
                hackPart:Destroy()
                -- cFrame = cFrame * CFrame.Angles(math.rad(yaw), math.rad(pitch), 0)
                transform.cFrame = transform.cFrame:Lerp((cFrame - (cFrame.LookVector * zoom)), step * camera.lerpSpeed)
                mouseScrollWheel = 0
                mouseChange = Vector3.new()
            end
            Camera.CFrame = transform.cFrame
            Camera.FieldOfView = camera.fieldOfView
        end, entity)
    end
end