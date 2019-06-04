-- TrafficConeGod

local UserInputService = game:GetService("UserInputService")

return function(Sunshine, entity)
    local input = entity.input
    if input then
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
            input.space = UserInputService:IsKeyDown(Enum.KeyCode.Space) or UserInputService:IsGamepadButtonDown(Enum.UserInputType.Gamepad1, Enum.KeyCode.ButtonA) or UserInputService:IsGamepadButtonDown(Enum.UserInputType.Gamepad1, Enum.KeyCode.ButtonB)
            input.shift = UserInputService:IsKeyDown(Enum.KeyCode.LeftShift)
            input.e = UserInputService:IsKeyDown(Enum.KeyCode.E) or UserInputService:IsGamepadButtonDown(Enum.UserInputType.Gamepad1, Enum.KeyCode.ButtonY) or UserInputService:IsGamepadButtonDown(Enum.UserInputType.Gamepad1, Enum.KeyCode.ButtonX)
            local camera = Sunshine:getEntityById(input.camera)
            if camera and camera.transform then
                local cameraCFrame = CFrame.new(Vector3.new(), Vector3.new(camera.transform.cFrame.LookVector.X, 0, camera.transform.cFrame.LookVector.Z))
                local moveVector = Vector3.new()
                if UserInputService:GetLastInputType() ~= Enum.UserInputType.Gamepad1 then
                    if UserInputService:IsKeyDown(Enum.KeyCode.W) then
                        moveVector = moveVector - Vector3.new(0, 0, 1)
                    end
                    if UserInputService:IsKeyDown(Enum.KeyCode.S) then
                        moveVector = moveVector + Vector3.new(0, 0, 1)
                    end
                    if UserInputService:IsKeyDown(Enum.KeyCode.D) then
                        moveVector = moveVector + Vector3.new(1, 0, 0)
                    end
                    if UserInputService:IsKeyDown(Enum.KeyCode.A) then
                        moveVector = moveVector - Vector3.new(1, 0, 0)
                    end
                elseif position then
                    moveVector = Vector3.new(position.X, 0, -position.Y)
                end
                moveVector = cameraCFrame:VectorToWorldSpace(moveVector)
                if moveVector ~= Vector3.new() then
                    moveVector = moveVector.Unit
                end
                if UserInputService:GetFocusedTextBox() == nil then
                    input.moveVector = moveVector
                else
                    input.moveVector = Vector3.new(0,0,0)
                end
            end
        end)
    end
end