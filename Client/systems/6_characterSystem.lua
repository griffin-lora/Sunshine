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

local function dotToLerp(dot)
    dot = dot + 1
    dot = dot / 2
    return dot
end

return function(Sunshine, entity)
    local character = entity.character
    local model = entity.model
    local input = entity.input
    local transform = entity.transform
    local physics = entity.physics
    local animator = entity.animator
    local health = entity.health
    local tag = entity.tag
    local gravity = entity.gravity
    if character and model and transform and physics and animator and gravity then
        local lastGroundeds = {}
        local lastVelocity
        local lastMoveVector
        model.model.PrimaryPart.CanCollide = false
        local hitbox = model.model.PrimaryPart:Clone()
        hitbox.Name = "Hitbox"
        hitbox.CanCollide = true
        local weldConstraint = Instance.new("WeldConstraint")
        weldConstraint.Part0 = model.model.PrimaryPart
        weldConstraint.Part1 = hitbox
        hitbox.Parent = model.model
        model.model.PrimaryPart = hitbox
        hitbox.Position = vector3New(hitbox.Position.X, hitbox.Position.Y + 2, hitbox.Position.Z)
        Sunshine:update(function(step)
            local distance = -transform.cFrame.UpVector * ((model.model.PrimaryPart.Size.Y / 2) + 3)
            local size = Vector3.new(model.model.PrimaryPart.Size.X / 2, 0, model.model.PrimaryPart.Size.Z / 2)
            local raycasts = {}
            raycasts[1] = {Sunshine:findPartOnRay(rayNew(transform.cFrame.Position, distance), {model.model})}
            raycasts[2] = {Sunshine:findPartOnRay(rayNew(transform.cFrame.Position + vector3New(size.X, 0, 0), distance),
            {model.model})}
            raycasts[3] = {Sunshine:findPartOnRay(rayNew(transform.cFrame.Position - vector3New(size.X, 0, 0), distance),
            {model.model})}
            raycasts[4] = {Sunshine:findPartOnRay(rayNew(transform.cFrame.Position + vector3New(0, 0, size.Z), distance),
            {model.model})}
            raycasts[5] = {Sunshine:findPartOnRay(rayNew(transform.cFrame.Position - vector3New(0, 0, size.Z), distance),
            {model.model})}
            local part, position, normal, material
            for _, raycast in pairs(raycasts) do
                if raycast[1] then
                    part, position, normal, material = raycast[1], raycast[2], raycast[3], raycast[4]
                end
            end
            character.grounded = not not part and physics.velocity.Y < 0.05 and material ~= Enum.Material.Water
            character.floor = part
            local wallPart, _, wallNormal, wallMaterial = Sunshine:findPartOnRay(rayNew(transform.cFrame.Position,
            transform.cFrame.LookVector * 2), {model.model})
            character.onWall = not not wallPart and wallMaterial ~= Enum.Material.Water
            character.wall = wallPart
            character.wallNormal = wallNormal
            gravity.ignore = character.grounded
            if character.moving then
                if not character.swimming then
                    animator.movement = character.moveAnimation
                else
                    animator.movement = character.swimAnimation
                end
            else
                animator.movement = character.idleAnimation
            end
            if not character.grounded and physics.velocity.Y < -0.5 then
                if not character.swimming then
                    animator.movement = character.fallAnimation
                elseif not character.moving then
                    animator.movement = character.sinkAnimation
                end
            end
            if (input and character.controllable) or character.moveVector then
                local moveVector = character.moveVector or input.moveVector
                character.moving = moveVector ~= vector3New()
                local boost = 0
                if character.grounded then
                    -- local closestPoint = getClosestPointOnPlane(vector3New(), normal, moveVector)
                    -- moveVector = closestPoint
                    -- physics.velocity = vector3New(physics.velocity.X, moveVector.Y * 50, physics.velocity.Z)
                    -- boost = -moveVector.Y * 10
                end
                if character.moving and physics.movable and lastMoveVector then
                    transform.cFrame = transform.cFrame:Lerp(CFrame.new(transform.cFrame.Position,
                    transform.cFrame.Position + moveVector), step * moveVector:Dot(lastMoveVector) * 12)
                end
                local damping = 0.5
                local canLoseMagnitude = true
                local fullyGrounded = lastGroundeds[1] and lastGroundeds[2] and character.grounded
                if not fullyGrounded then
                    canLoseMagnitude = false
                elseif moveVector == vector3New() then
                    damping = 0.7
                end
                if character.canLoseMagnitude or character.swimming or (lastGroundeds[1] and character.grounded) then
                    canLoseMagnitude = true
                end
                local function calculateVelocity()
                    local walkSpeed = character.walkSpeed * character.walkSpeedFactor
                    local xVelocity = physics.velocity.X
                    xVelocity = xVelocity + (moveVector.X * walkSpeed + (boost * moveVector.X))
                    xVelocity = xVelocity * math.pow(1 - damping, step * 10)
                    local zVelocity = physics.velocity.Z
                    zVelocity = zVelocity + (moveVector.Z * walkSpeed + (boost * moveVector.Z))
                    zVelocity = zVelocity * math.pow(1 - damping, step * 10)
                    return vector3New(xVelocity, 0, zVelocity)
                end
                local velocity = calculateVelocity()
                if not canLoseMagnitude and lastVelocity and velocity.Magnitude < lastVelocity.Magnitude then
                    if velocity.Unit.Magnitude == velocity.Unit.Magnitude then
                        if character.moving then
                            velocity = velocity:Lerp(velocity.Unit * lastVelocity.Magnitude,
                            dotToLerp(moveVector:Dot(velocity.Unit)))
                        else
                            velocity = velocity.Unit * lastVelocity.Magnitude
                        end
                    else
                        velocity = lastVelocity
                    end
                end
                if character.grounded then
                    local stepUpPart, stepUpPosition = Sunshine:findPartOnRay(rayNew(transform.cFrame.Position +
                    (moveVector), distance), {model.model})
                    if stepUpPart ~= part then
                        transform.cFrame = (transform.cFrame - Vector3.new(0, transform.cFrame.Y, 0)) + Vector3.new(0,
                        stepUpPosition.Y + ((model.model.PrimaryPart.Size.Y / 2) + 0.1), 0)
                    else
                        local stepDownPart, stepDownPosition = Sunshine:findPartOnRay(rayNew(transform.cFrame.Position,
                        distance * 2), {model.model})
                        if stepDownPart ~= part then
                            transform.cFrame = (transform.cFrame - Vector3.new(0, transform.cFrame.Y, 0)) +
                            Vector3.new(0, stepDownPosition.Y + ((model.model.PrimaryPart.Size.Y / 2) + 0.1), 0)
                        end
                    end
                end
                physics.velocity = vector3New(velocity.X, physics.velocity.Y, velocity.Z)
                if character.grounded then
                    transform.cFrame = (transform.cFrame - vector3New(0, transform.cFrame.Y)) + vector3New(0, position.Y + (model.model.PrimaryPart.Size.Y / 2) + 2)
                    physics.velocity = vector3New(physics.velocity.X, 0, physics.velocity.Z)
                end
                lastMoveVector = moveVector
                lastVelocity = velocity
                lastGroundeds[2] = lastGroundeds[1]
                lastGroundeds[1] = character.grounded
                if health and tag and tag.tag == "character" then
                    if health.health <= 0 then
                        Sunshine:reloadScene(entity.core.scene)
                    end
                end
            end
        end, entity)
    end
end