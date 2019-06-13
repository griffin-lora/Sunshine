-- TrafficConeGod and Phenite (math help)

local rayNew = Ray.new
local vector3New = Vector3.new

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
        local lastGroundeds = {}
        local lastVelocity
        local lastMoveVector
        Sunshine:update(function(step)
            local distance = -transform.cFrame.UpVector * 3.3
            local raycasts = {}
            raycasts[1] = {Sunshine:findPartOnRay(rayNew(transform.cFrame.Position, distance), {model.model})}
            raycasts[2] = {Sunshine:findPartOnRay(rayNew(transform.cFrame.Position + vector3New(size, 0, 0), distance), {model.model})}
            raycasts[3] = {Sunshine:findPartOnRay(rayNew(transform.cFrame.Position - vector3New(size, 0, 0), distance), {model.model})}
            raycasts[4] = {Sunshine:findPartOnRay(rayNew(transform.cFrame.Position + vector3New(0, 0, size), distance), {model.model})}
            raycasts[5] = {Sunshine:findPartOnRay(rayNew(transform.cFrame.Position - vector3New(0, 0, size), distance), {model.model})}
            local part, position, normal
            for index, raycast in pairs(raycasts) do
                if raycast[1] then
                    part, position, normal = raycast[1], raycast[2], raycast[3]
                end
            end
            character.grounded = not not part
            if character.grounded then
                physics.velocity = vector3New(physics.velocity.X, 0, physics.velocity.Z)
            end
            if character.controllable then
                local moveVector = input.moveVector
                character.moving = moveVector ~= vector3New()
                local boost = 0
                if character.grounded then
                    local closestPoint = getClosestPointOnPlane(vector3New(), normal, moveVector)
                    moveVector = closestPoint
                    physics.velocity = vector3New(physics.velocity.X, moveVector.Y * 50, physics.velocity.Z)
                    boost = -moveVector.Y * 10
                end
                if animator then
                    if character.moving then
                        animator.movement = 3214734207
                    else
                        animator.movement = 507766388
                    end
                    if not character.grounded and physics.velocity.Y < -0.5 then
                        animator.movement = 507767968
                    end
                end
                if character.moving and physics.movable and lastMoveVector then
                    transform.cFrame = transform.cFrame:Lerp(CFrame.new(transform.cFrame.Position, transform.cFrame.Position + moveVector), step * moveVector:Dot(lastMoveVector) * 12)
                end
                local damping = 0.5
                local canLoseMagnitude = true
                local fullyGrounded = lastGroundeds[2] and lastGroundeds[1] and character.grounded
                if not fullyGrounded then
                    canLoseMagnitude = false
                elseif moveVector == vector3New() then
                    damping = 0.7
                end
                if character.state == "throw" or character.state == "bounce" then -- hacky fix
                    canLoseMagnitude = true
                end
                local walkSpeed = character.walkSpeed * character.walkSpeedFactor
                local xVelocity = physics.velocity.X
                xVelocity = xVelocity + (moveVector.X * walkSpeed + (boost * moveVector.X))
                xVelocity = xVelocity * math.pow(1 - damping, step * 10)
                local zVelocity = physics.velocity.Z
                zVelocity = zVelocity + (moveVector.Z * walkSpeed + (boost * moveVector.Z))
                zVelocity = zVelocity * math.pow(1 - damping, step * 10)
                local velocity = vector3New(xVelocity, 0, zVelocity)
                if not canLoseMagnitude and lastVelocity and velocity.Magnitude < lastVelocity.Magnitude then
                    if velocity.Unit.Magnitude == velocity.Unit.Magnitude then
                        if character.moving then
                            velocity = velocity:Lerp(velocity.Unit * lastVelocity.Magnitude, moveVector:Dot(lastMoveVector))
                        else
                            velocity = velocity.Unit * lastVelocity.Magnitude
                        end
                    else
                        velocity = lastVelocity
                    end
                end
                local stepPart, stepPosition = Sunshine:findPartOnRay(rayNew(transform.cFrame.Position + (velocity * step * 20), distance), {model.model})
                -- if stepPart ~= part then
                --     transform.cFrame = (transform.cFrame - Vector3.new(0, transform.cFrame.Y, 0)) + Vector3.new(0, stepPosition.Y + 3, 0)
                -- end
                physics.velocity = vector3New(velocity.X, physics.velocity.Y, velocity.Z)
                lastMoveVector = moveVector
                lastVelocity = velocity
                lastGroundeds[2] = lastGroundeds[1]
                lastGroundeds[1] = character.grounded
            end
        end, entity)
    end
end