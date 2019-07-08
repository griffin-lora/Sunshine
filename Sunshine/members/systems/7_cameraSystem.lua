-- TrafficConeGod

local UserInputService = game:GetService("UserInputService")
local Camera = workspace.Camera

return function(Sunshine, entity, scene)
    local camera = entity.camera
    local transform = entity.transform
    if camera and transform then
        local zoom = (camera.minZoom + camera.maxZoom) / 2
        local yaw = -30
        local pitch = 0
        local mouseDown = false
        local mouseScrollWheel = 0
        local mouseChange = Vector3.new()
        local position = Vector3.new()
        local function handleInput(inputObject)
            if not UserInputService.GamepadEnabled then
                if inputObject.UserInputType == Enum.UserInputType.MouseWheel then
                    mouseScrollWheel = inputObject.Position.Z
                elseif inputObject.UserInputType == Enum.UserInputType.MouseButton2 then
                    mouseDown = inputObject.UserInputState == Enum.UserInputState.Begin
                elseif inputObject.UserInputType == Enum.UserInputType.MouseMovement then
                    mouseChange = inputObject.Delta
                end
            else
                if inputObject.KeyCode == Enum.KeyCode.Thumbstick2 then
                    if inputObject.Position.Magnitude > 0.2 then
                        position = inputObject.Position
                    else
                        position = Vector3.new()
                    end
                end
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
                if mouseDown or position then
                    local change = mouseChange
                    if UserInputService.GamepadEnabled then
                        change = Vector3.new(position.X, -position.Y, 0) * 5
                    end
                    yaw = yaw - (change.Y * camera.rotateSpeed)
                    yaw = math.clamp(yaw, -80, 80)
                    pitch = pitch - (change.X * camera.rotateSpeed)
                end
                local hackPart = Instance.new("Part") -- This is hacky code 101. But euler angles work differently and
                -- I can't be bothered to look up the math to do it.
                hackPart.Orientation = Vector3.new(yaw, pitch, 0)
                local cFrame = CFrame.new(subject.transform.cFrame.Position, subject.transform.cFrame.Position
                + hackPart.CFrame.LookVector)
                hackPart:Destroy()
                -- cFrame = cFrame * CFrame.Angles(math.rad(yaw), math.rad(pitch), 0)
                local newCFrame = transform.cFrame:Lerp((cFrame - (cFrame.LookVector * zoom)), step * camera.lerpSpeed)
                -- local part, position = Sunshine:findPartOnRay(Ray.new(transform.cFrame.Position, newCFrame.Position -
                -- transform.cFrame.Position), {})
                -- if not part then
                --     transform.cFrame = CFrame.new(position, position + newCFrame.LookVector)
                -- end
                transform.cFrame = newCFrame
                mouseScrollWheel = 0
                mouseChange = Vector3.new()
            end
            Camera.CFrame = transform.cFrame
            Camera.FieldOfView = camera.fieldOfView
        end, entity)
    end
end