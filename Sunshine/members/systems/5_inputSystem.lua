-- TrafficConeGod

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
        local function handleInput(input, gameProcessedEvent)
            if not gameProcessedEvent then
                local begin = input.UserInputState == Enum.UserInputState.Begin
                if input.KeyCode == Enum.KeyCode.D then
                    d = begin
                elseif input.KeyCode == Enum.KeyCode.A then
                    a = begin
                elseif input.KeyCode == Enum.KeyCode.S then
                    s = begin
                elseif input.KeyCode == Enum.KeyCode.W then
                    w = begin
                elseif input.KeyCode == Enum.KeyCode.Space then
                    space = begin
                elseif input.KeyCode == Enum.KeyCode.LeftShift then
                    shift = begin
                elseif input.KeyCode == Enum.KeyCode.E then
                    e = begin
                end
            end
        end
        Sunshine:addConnection(UserInputService.InputBegan, handleInput)
        Sunshine:addConnection(UserInputService.InputEnded, handleInput)
        local position
        Sunshine:addConnection(UserInputService.InputChanged, function(input)
            if input.KeyCode == Enum.KeyCode.Thumbstick1 then
                if input.Position.Magnitude > 0.2 then
                    position = input.Position
                else
                    position = Vector3.new()
                end
            end
        end)
        Sunshine:update(function()
            input.space = space or UserInputService:IsGamepadButtonDown(Enum.UserInputType.Gamepad1, Enum.KeyCode.ButtonA) or UserInputService:IsGamepadButtonDown(Enum.UserInputType.Gamepad1, Enum.KeyCode.ButtonB)
            input.shift = shift
            input.e = e or UserInputService:IsGamepadButtonDown(Enum.UserInputType.Gamepad1, Enum.KeyCode.ButtonY) or UserInputService:IsGamepadButtonDown(Enum.UserInputType.Gamepad1, Enum.KeyCode.ButtonX)
            local camera = Sunshine:getEntityById(input.camera)
            if camera and camera.transform then
                local cameraCFrame = CFrame.new(Vector3.new(), Vector3.new(camera.transform.cFrame.LookVector.X, 0, camera.transform.cFrame.LookVector.Z))
                local moveVector = Vector3.new()
                if UserInputService:GetLastInputType() ~= Enum.UserInputType.Gamepad1 then
                    if d then
                        moveVector = moveVector + Vector3.new(1, 0, 0)
                    end
                    if a then
                        moveVector = moveVector - Vector3.new(1, 0, 0)
                    end
                    if s then
                        moveVector = moveVector + Vector3.new(0, 0, 1)
                    end
                    if w then
                        moveVector = moveVector - Vector3.new(0, 0, 1)
                    end
                elseif position then
                    moveVector = Vector3.new(position.X, 0, -position.Y)
                end
                moveVector = cameraCFrame:VectorToWorldSpace(moveVector)
                if moveVector ~= Vector3.new() then
                    moveVector = moveVector.Unit
                end
                input.moveVector = moveVector
            end
        end)
    end
end