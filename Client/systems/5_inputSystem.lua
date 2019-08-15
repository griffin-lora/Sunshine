-- TrafficConeGod

local vector3New = Vector3.new

local UserInputService = game:GetService("UserInputService")

return function(Sunshine, entity)
    local input = entity.input
    if input then
        local d = false
        local a = false
        local s = false
        local w = false
        local space = false
        local shift = false
        local e = false
        local r2 = false
        local l2 = false
        local position
        local function handleInput(inputObject, gameProcessedEvent)
            if not gameProcessedEvent then
                local begin = inputObject.UserInputState == Enum.UserInputState.Begin
                if inputObject.KeyCode == Enum.KeyCode.D then
                    d = begin
                elseif inputObject.KeyCode == Enum.KeyCode.A then
                    a = begin
                elseif inputObject.KeyCode == Enum.KeyCode.S then
                    s = begin
                elseif inputObject.KeyCode == Enum.KeyCode.W then
                    w = begin
                elseif inputObject.KeyCode == Enum.KeyCode.Space then
                    space = begin
                elseif inputObject.KeyCode == Enum.KeyCode.LeftShift then
                    shift = begin
                elseif inputObject.KeyCode == Enum.KeyCode.E or inputObject.UserInputType == Enum.UserInputType.MouseButton1 then
                    e = begin
                elseif inputObject.KeyCode == Enum.KeyCode.ButtonR2 then
                    r2 = begin
                elseif inputObject.KeyCode == Enum.KeyCode.ButtonL2 then
                    l2 = begin
                end
                if inputObject.KeyCode == Enum.KeyCode.Thumbstick1 then
                    if inputObject.Position.Magnitude > 0.2 then
                        position = inputObject.Position
                    else
                        position = vector3New()
                    end
                end
            end
        end
        Sunshine:addConnection(UserInputService.InputBegan, handleInput, entity, true)
        Sunshine:addConnection(UserInputService.InputChanged, handleInput, entity, true)
        Sunshine:addConnection(UserInputService.InputEnded, handleInput, entity, true)
        Sunshine:update(function()
            input.space = space or
            UserInputService:IsGamepadButtonDown(Enum.UserInputType.Gamepad1, Enum.KeyCode.ButtonA) or
            UserInputService:IsGamepadButtonDown(Enum.UserInputType.Gamepad1, Enum.KeyCode.ButtonB)
            input.shift = shift or r2 or l2
            input.e = e or
            UserInputService:IsGamepadButtonDown(Enum.UserInputType.Gamepad1, Enum.KeyCode.ButtonY) or
            UserInputService:IsGamepadButtonDown(Enum.UserInputType.Gamepad1, Enum.KeyCode.ButtonX)
            local camera = Sunshine:getEntity(input.camera, entity.core.scene)
            if camera and camera.transform then
                local cameraCFrame = CFrame.new(vector3New(), vector3New(camera.transform.cFrame.LookVector.X,
                0, camera.transform.cFrame.LookVector.Z))
                local moveVector = vector3New()
                if UserInputService:GetLastInputType() ~= Enum.UserInputType.Gamepad1 then
                    if d then
                        moveVector = moveVector + vector3New(1, 0, 0)
                    end
                    if a then
                        moveVector = moveVector - vector3New(1, 0, 0)
                    end
                    if s then
                        moveVector = moveVector + vector3New(0, 0, 1)
                    end
                    if w then
                        moveVector = moveVector - vector3New(0, 0, 1)
                    end
                elseif position then
                    moveVector = vector3New(position.X, 0, -position.Y)
                end
                moveVector = cameraCFrame:VectorToWorldSpace(moveVector)
                if moveVector ~= vector3New() then
                    moveVector = moveVector.Unit
                end
                input.moveVector = moveVector
            end
        end, entity)
    end
end