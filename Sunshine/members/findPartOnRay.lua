return function(Sunshine, ray, ignoreList)
    local part, position, normal = workspace:FindPartOnRayWithIgnoreList(ray, ignoreList)
    if part and not part.CanCollide then
        ignoreList[#ignoreList + 1] = part
        return Sunshine:findPartOnRay(ray, ignoreList)
    end
    return part, position, normal
end