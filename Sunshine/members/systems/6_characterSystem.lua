local UserInputService = game:GetService("UserInputService")
local player = game.Players.LocalPlayer

return function(Sunshine, entity)
    local character = entity.character
    local transform = entity.transform
    local physics = entity.physics
    if character and transform and physics then
        Sunshine:update(function()
            if character.controllable then
                local camera = Sunshine:getEntityById(character.camera)
                if camera and camera.transform then
                    local cameraCFrame = CFrame.new(Vector3.new(), Vector3.new(camera.transform.cFrame.LookVector.X, 0, camera.transform.cFrame.LookVector.Z))
                    local moveVector = Vector3.new()
                    if UserInputService:IsKeyDown(Enum.KeyCode.W) then
                        moveVector = moveVector + cameraCFrame.LookVector
                    end
                    if UserInputService:IsKeyDown(Enum.KeyCode.S) then
                        moveVector = moveVector - cameraCFrame.LookVector
                    end
                    if UserInputService:IsKeyDown(Enum.KeyCode.D) then
                        moveVector = moveVector + cameraCFrame.RightVector
                    end
                    if UserInputService:IsKeyDown(Enum.KeyCode.A) then
                        moveVector = moveVector - cameraCFrame.RightVector
                    end
                    if moveVector ~= Vector3.new() then
                        moveVector = moveVector.Unit
                    end
                    physics.velocity = (moveVector * character.walkSpeed) + Vector3.new(0, physics.velocity.Y, 0)
                    -- physics.angularVelocity = Vector3.new(CFrame.new(Vector3.new(), moveVector):ToEulerAnglesXYZ())
                end
            end
        end)
    end
end