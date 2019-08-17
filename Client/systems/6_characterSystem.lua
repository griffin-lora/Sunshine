-- TrafficConeGod and Phenite (math help)

local rayNew = Ray.new
local vector3New = Vector3.new
local BLANK_VECTOR3 = vector3New()

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
        hitbox:ClearAllChildren()
        local weldConstraint = Instance.new("WeldConstraint")
        weldConstraint.Part0 = model.model.PrimaryPart
        weldConstraint.Part1 = hitbox
        weldConstraint.Parent = hitbox
        hitbox.Parent = model.model
        model.model.PrimaryPart = hitbox
        hitbox.Position = vector3New(hitbox.Position.X, hitbox.Position.Y + 1, hitbox.Position.Z)
        hitbox.Size = vector3New(hitbox.Size.X, hitbox.Size.Y - 2, hitbox.Size.Z)
        Sunshine:update(function(step)
            local distance = -transform.cFrame.UpVector * ((model.model.PrimaryPart.Size.Y / 2) + 3)
            local size = Vector3.new(model.model.PrimaryPart.Size.X / 2, 0, model.model.PrimaryPart.Size.Z / 2)
            local raycasts = {}
            raycasts[1] = {Sunshine:findPartOnRay(rayNew(transform.cFrame.Position, distance), {model.model})}
            raycasts[2] = {Sunshine:findPartOnRay(rayNew(transform.cFrame.Position + vector3New(size.X, 0, 0), distance)
            ,{model.model})}
            raycasts[3] = {Sunshine:findPartOnRay(rayNew(transform.cFrame.Position - vector3New(size.X, 0, 0), distance)
            ,{model.model})}
            raycasts[4] = {Sunshine:findPartOnRay(rayNew(transform.cFrame.Position + vector3New(0, 0, size.Z), distance)
            ,{model.model})}
            raycasts[5] = {Sunshine:findPartOnRay(rayNew(transform.cFrame.Position - vector3New(0, 0, size.Z), distance)
            ,{model.model})}
            local part, position, material
            for _, raycast in pairs(raycasts) do
                if raycast[1] then
                    part, position, _, material = raycast[1], raycast[2], raycast[3], raycast[4]
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
                animator.movementSpeed = Vector3.new(physics.velocity.X, 0, physics.velocity.Z).Magnitude /
                (character.walkSpeed * 6.16580200195)
                if not character.swimming then
                    animator.movement = character.moveAnimation
                else
                    animator.movement = character.swimAnimation
                end
            else
                animator.movementSpeed = 1
                animator.movement = character.idleAnimation
            end
            if not character.grounded and physics.velocity.Y < -0.5 then
                animator.movementSpeed = 1
                if not character.swimming then
                    animator.movement = character.fallAnimation
                elseif not character.moving then
                    animator.movement = character.sinkAnimation
                end
            end
            if (input and character.controllable) or character.moveVector then
                local moveVector = character.moveVector or input.moveVector
                character.moving = moveVector ~= BLANK_VECTOR3
                if character.moving and physics.movable and lastMoveVector then
                    transform.cFrame = transform.cFrame:Lerp(CFrame.new(transform.cFrame.Position,
                    transform.cFrame.Position + moveVector), step * moveVector:Dot(lastMoveVector) * 12)
                end
                local damping = 0.33
                local canLoseMagnitude = true
                local fullyGrounded = lastGroundeds[1] and lastGroundeds[2] and character.grounded
                if not fullyGrounded then
                    canLoseMagnitude = false
                elseif moveVector == BLANK_VECTOR3 then
                    damping = 0.75
                end
                if character.canLoseMagnitude or character.swimming or (lastGroundeds[1] and character.grounded) then
                    canLoseMagnitude = true
                end
                local function calculateVelocity()
                    local walkSpeed = character.walkSpeed * character.walkSpeedFactor * 0.56363762272
                    local xVelocity = physics.velocity.X
                    xVelocity = xVelocity + (moveVector.X * walkSpeed)
                    xVelocity = xVelocity * math.pow(1 - damping, step * 10)
                    local zVelocity = physics.velocity.Z
                    zVelocity = zVelocity + (moveVector.Z * walkSpeed)
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
                physics.velocity = vector3New(velocity.X, physics.velocity.Y, velocity.Z)
                if character.grounded then
                    transform.cFrame = (transform.cFrame - vector3New(0, transform.cFrame.Y)) + vector3New(0, position.Y
                    + (model.model.PrimaryPart.Size.Y / 2) + 2)
                    physics.velocity = vector3New(physics.velocity.X, 0, physics.velocity.Z)
                end
                lastMoveVector = moveVector
                lastVelocity = velocity
                lastGroundeds[2] = lastGroundeds[1]
                lastGroundeds[1] = character.grounded
                if health and tag and tag.tag == "character" then
                    if health.health <= 0 then
                        local cutout
                        for _, otherEntity in pairs(Sunshine.scenes[2].entities) do
                            if otherEntity.tag and otherEntity.tag.tag == "sceneTransition" then
                                cutout = otherEntity
                                break
                            end
                        end
                        cutout.sceneTransition.type = "death"
                        cutout.sceneTransition.loading = true
                    end
                end
            end
        end, entity)
    end
end