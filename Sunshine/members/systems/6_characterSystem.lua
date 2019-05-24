local UserInputService = game:GetService("UserInputService")
local player = game.Players.LocalPlayer

local function getClosestPointOnPlane(point, normal, vector)
    local D = point.X * normal.X + point.Y * normal.Y + point.Z * normal.Z
    local A,B,C = normal.X, normal.Y, normal.Z
    local distance = math.abs(A * vector.X + B * vector.Y + C * vector.Z + D) / math.sqrt(A^2 + B^2 + C^2)
    local pos1 = vector + normal * distance
    local pos2 = vector - normal * distance
    local d1 = A * pos1.X + B * pos1.Y + C * pos1.Z
    local d2 = A * pos2.X + B * pos2.Y + C * pos2.Z
    if math.abs(D - d1) < math.abs(D - d2) then
        return pos1
    else
        return pos2
    end
end

return function(Sunshine, entity)
    local character = entity.character
    local model = entity.model
    local transform = entity.transform
    local physics = entity.physics
    local animator = entity.animator
    if character and model and transform and physics then
        Sunshine:update(function(step)
            local part, position, normal = workspace:FindPartOnRay(Ray.new(transform.cFrame.Position, -transform.cFrame.UpVector * 3.2), model.model)
            character.grounded = not not part
            if character.grounded then
                physics.velocity = Vector3.new(physics.velocity.X, 0, physics.velocity.Z)
            end
            if character.controllable then
                local camera = Sunshine:getEntityById(character.camera)
                local lastMoveVector
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
                    if character.grounded then
                        local closestPoint = getClosestPointOnPlane(Vector3.new(), normal, moveVector)
                        moveVector = closestPoint
                        physics.velocity = Vector3.new(physics.velocity.X, moveVector.Y * 50, physics.velocity.Z)
                    end
                    if moveVector ~= Vector3.new() then
                        moveVector = moveVector.Unit
                        transform.cFrame = transform.cFrame:Lerp(CFrame.new(transform.cFrame.Position, transform.cFrame.Position + moveVector), step * character.walkSpeed)
                    end
                    if animator then
                        if moveVector ~= Vector3.new() then
                            animator.movement = 3192107875
                        else
                            animator.movement = 507766388
                        end
                        if not character.grounded then
                            animator.movement = 507767968
                        end
                    end
                    local damping = 0.5
                    if lastMoveVector ~= Vector3.new() and moveVector == Vector3.new() then
                        damping = 0.7
                    end
                    lastMoveVector = moveVector
                    local xVelocity = physics.velocity.X
                    xVelocity = xVelocity + (moveVector.X * character.walkSpeed)
                    xVelocity = xVelocity * math.pow(1 - damping, step * 10)
                    local zVelocity = physics.velocity.Z
                    zVelocity = zVelocity + (moveVector.Z * character.walkSpeed)
                    zVelocity = zVelocity * math.pow(1 - damping, step * 10)
                    physics.velocity = Vector3.new(xVelocity, physics.velocity.Y, zVelocity)
                end
            end
        end)
    end
end