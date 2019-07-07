-- TrafficConeGod

local UserInputService = game:GetService("UserInputService")
local Camera = workspace.Camera

-- private float yaw = 30
-- 	private float pitch = 0
-- 	private float offset = 15
-- 	private float visualOffset = 15
-- 	public GameObject character
-- 	public float rotateSpeed = 5
-- 	public float maxYaw = 85
-- 	public float minYaw = -85
-- 	public float scrollSpeed = 10
-- 	public float maxOffset = 30
-- 	public float minOffset = 2

return function(Sunshine, entity, scene)
    local camera = entity.camera
    local transform = entity.transform
    if camera and transform then
        local offset = 15
        local yaw = 30
        local pitch = 0
        -- TEMP
        local rotateSpeed = 5
        local scrollSpeed = 10
        local maxOffset = 30
        local minOffset = 2
        local mouseDown = false
        local mouseScrollWheel = 0
        local mouseChange = Vector3.new()
        local function handleInput(inputObject)
            if inputObject.UserInputType == Enum.UserInputType.MouseWheel then
                mouseScrollWheel = inputObject.Position.Z
            elseif inputObject.UserInputType == Enum.UserInputType.MouseButton2 then
                mouseDown = inputObject.UserInputState == Enum.UserInputState.Begin
            elseif inputObject.UserInputType == Enum.UserInputType.MouseMovement then
                mouseChange = inputObject.Delta
            end
        end
        Sunshine:addConnection(UserInputService.InputBegan, handleInput, entity, true)
        Sunshine:addConnection(UserInputService.InputChanged, handleInput, entity, true)
        Sunshine:addConnection(UserInputService.InputEnded, handleInput, entity, true)
        Sunshine:update(function()
            local subject = Sunshine:getEntity(camera.subject, scene)
            if subject and camera.controllable then
                offset = offset - (mouseScrollWheel * scrollSpeed)
                offset = math.clamp(offset, minOffset, maxOffset)
                if mouseDown then
                    yaw = yaw - (mouseChange.Y * rotateSpeed)
                    yaw = math.clamp(yaw, -85, 85)
                    pitch = pitch + (mouseChange.X * rotateSpeed)
                end
                -- visualOffset = Mathf.Lerp(visualOffset, offset, Time.deltaTime * scrollSpeed)

                transform.cFrame = CFrame.new(subject.transform.cFrame.Position)
                transform.cFrame = transform.cFrame * CFrame.Angles(math.rad(yaw), math.rad(pitch), 0)
                transform.cFrame = (transform.cFrame - (transform.cFrame.LookVector * offset))
                mouseScrollWheel = 0
                Camera.CFrame = transform.cFrame
            end
            Camera.FieldOfView = camera.fieldOfView
        end, entity)
    end
end