local workspaceFindPart = workspace.FindPartOnRayWithIgnoreList

return function(Sunshine, ray, ignoreList)
    local part, position, normal, material = workspaceFindPart(workspace, ray, ignoreList)
    if part and not part.CanCollide then
        ignoreList[#ignoreList + 1] = part
        return Sunshine:findPartOnRay(ray, ignoreList)
    end
    return part, position, normal, material
end