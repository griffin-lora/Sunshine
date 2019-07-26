--[[

    The Sunshine Engine
    Written by TrafficConeGod and SuperMakerPlayer
    Gen is holding me and many other devs in his basement and making me develop various nuts

]]

local folder = script

local function getMember(instance)
    if instance:IsA("ModuleScript") then
        return require(instance)
    elseif instance:IsA("Folder") then
        local member = {}
        for _, child in pairs(instance:GetChildren()) do
            member[child.Name] = getMember(child)
        end
        return member
    end
end

local Sunshine = setmetatable({}, {
    __index = function(Sunshine, name)
        -- This just routes an index to the correct module in the members folder.
        -- For example Sunshine.someIndex will return the required someIndex.lua file
        local member
        if folder.members:FindFirstChild(name) then
            local instance = folder.members[name]
            member = getMember(instance)
        end
        Sunshine[name] = member
        return member
    end
})

Sunshine:setTopbarEnabled(false)
Sunshine:manageErrors()
Sunshine:manageDebugMode()
Sunshine:managePauseMenu()

return Sunshine