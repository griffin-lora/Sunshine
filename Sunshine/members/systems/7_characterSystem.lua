-- TrafficConeGod and Phenite (math help)

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
local size = 0.7

return function(Sunshine, entity)
    local character = entity.character
    local model = entity.model
    local input = entity.input
    local transform = entity.transform
    local physics = entity.physics
    local animator = entity.animator
    if character and model and input and transform and physics and animator then
        Sunshine:update(function(step)
            local distance = -transform.cFrame.UpVector * 3.3
            local raycasts = {}
            raycasts[1] = {Sunshine:findPartOnRay(Ray.new(transform.cFrame.Position, distance), {model.model})}
            raycasts[2] = {Sunshine:findPartOnRay(Ray.new(transform.cFrame.Position + Vector3.new(size, 0, 0), distance), {model.model})}
            raycasts[3] = {Sunshine:findPartOnRay(Ray.new(transform.cFrame.Position - Vector3.new(size, 0, 0), distance), {model.model})}
            raycasts[4] = {Sunshine:findPartOnRay(Ray.new(transform.cFrame.Position + Vector3.new(0, 0, size), distance), {model.model})}
            raycasts[5] = {Sunshine:findPartOnRay(Ray.new(transform.cFrame.Position - Vector3.new(0, 0, size), distance), {model.model})}
            local part, position, normal
            for index, raycast in pairs(raycasts) do
                if raycast[1] then
                    part, position, normal = raycast[1], raycast[2], raycast[3]
                end
            end
            character.grounded = not not part
            if character.grounded then
                physics.velocity = Vector3.new(physics.velocity.X, 0, physics.velocity.Z)
            end
            if character.controllable then
                local moveVector = input.moveVector
                local boost = 0
                if character.grounded then
                    local closestPoint = getClosestPointOnPlane(Vector3.new(), normal, moveVector)
                    moveVector = closestPoint
                    physics.velocity = Vector3.new(physics.velocity.X, moveVector.Y * 50, physics.velocity.Z)
                    boost = -moveVector.Y * 10
                end
                if moveVector ~= Vector3.new() then
                    transform.cFrame = transform.cFrame:Lerp(CFrame.new(transform.cFrame.Position, transform.cFrame.Position + moveVector), step * character.walkSpeed)
                end
                if animator then
                    if moveVector ~= Vector3.new() then
                        animator.movement = 3214734207
                    else
                        animator.movement = 507766388
                    end
                    if not character.grounded and physics.velocity.Y < -0.5 then
                        animator.movement = 507767968
                    end
                end
                local damping = 0.5
                if not character.grounded and moveVector == Vector3.new() then
                    damping = 0
                elseif moveVector == Vector3.new() then
                    damping = 0.7
                end
                local walkSpeed = character.walkSpeed * character.walkSpeedFactor
                local xVelocity = physics.velocity.X
                xVelocity = xVelocity + (moveVector.X * walkSpeed + (boost * moveVector.X))
                xVelocity = xVelocity * math.pow(1 - damping, step * 10)
                local zVelocity = physics.velocity.Z
                zVelocity = zVelocity + (moveVector.Z * walkSpeed + (boost * moveVector.Z))
                zVelocity = zVelocity * math.pow(1 - damping, step * 10)
                physics.velocity = Vector3.new(xVelocity, physics.velocity.Y, zVelocity)
                if transform.cFrame.Y < (workspace.FallenPartsDestroyHeight + 50) then
                    Sunshine:loadScene(Sunshine.dataScene)
                end
            end
        end)
    end
end