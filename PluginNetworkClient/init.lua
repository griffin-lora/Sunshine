local PluginNetworkClient = {}
local clientEvents = {}
local plugin
local player = game:GetService("Players").LocalPlayer
local packetFolder = game:GetService("ServerStorage"):FindFirstChild("PNCPacketFolder") or Instance.new("Folder")
packetFolder.Name = "PNCPacketFolder"
packetFolder.Parent = game:GetService("ServerStorage")
local eventConnection = packetFolder.ChildAdded:Connect(function(packet)
    if packet:WaitForChild("from").Value ~= player then
        if packet:FindFirstChild("to") then
            if packet.to.Value == player then
                for _, event in pairs(clientEvents) do
                    event(packet.from.Value, unpack(require(packet)))
                end
            end
        else
            for _, event in pairs(clientEvents) do
                event(packet.from.Value, unpack(require(packet)))
            end
        end
    end
end)

function PluginNetworkClient.init(_, initPlugin)
    plugin = initPlugin
    local unloadConnection
    unloadConnection = plugin.Unloading:Connect(function()
        unloadConnection:Disconnect()
        eventConnection:Disconnect()
    end)
end

function PluginNetworkClient.encodeTable(_, table)
    local output = "{"
    for key, member in pairs(table) do
        local keyType = typeof(key)
        if keyType == "string" then
            output = output..key.."="
        elseif keyType ~= "number" then
            warn("The key type "..keyType.." is not supported.")
        end
        local memberType = typeof(member)
        if memberType == "number" then
            output = output..member
        elseif memberType == "string" then
            output = output.."'"..member.."'"
        elseif memberType == "boolean" then
            if member then
                output = output.."true"
            else
                output = output.."false"
            end
        elseif memberType == "table" then
            output = output..PluginNetworkClient:encodeTable(member)
        elseif memberType == "Instance" then
            output = output.."game."..member:GetFullName()
        elseif memberType == "CFrame" then
            local x, y, z, R00, R01, R02, R10, R11, R12, R20, R21, R22 = member:GetComponents()
            output = output.."CFrame.new("..x..","..y..","..z..","..R00..","..R01..","..R02..","..R10..","..R11..","
            ..R12..","..R20..","..R21..","..R22..")"
        elseif memberType == "Vector3" then
            local x, y, z = member.X, member.Y, member.Z
            output = output.."Vector3.new("..x..","..y..","..z..")"
        elseif memberType == "UDim2" then
            local xScale, xOffset, yScale, yOffset = member.X.Scale, member.X.Offset, member.Y.Scale, member.Y.Offset
            output = output.."UDim2.new("..xScale..","..xOffset..","..yScale..","..yOffset..")"
        elseif memberType == "Color3" then
            local r, g, b = member.r, member.g, member.b
            output = output.."Color3.new("..r..","..g..","..b..")"
        elseif memberType == "Vector2" then
            local x, y = member.X, member.Y
            output = output.."Vector2.new("..x..","..y..")"
        elseif memberType == "TweenInfo" then
            local time, style, direction = member.Time, member.EasingStyle, member.EasingDirection
            output = output.."TweenInfo.new("..time..","..tostring(style)..","..tostring(direction)..")"
        elseif memberType == "function" then
            output = output.."function()end"
        else
            warn("The member type "..memberType.." is not supported.")
        end
        output = output..","
    end
    output = output.."}"
    return output
end

function PluginNetworkClient.isEnabled()
    player = game:GetService("Players").LocalPlayer
    return not not player
end

function PluginNetworkClient.createPacket(_, ...)
    assert(plugin, "PNC is not initialized yet.")
    local packet = Instance.new("ModuleScript")
    local source = "return " .. PluginNetworkClient:encodeTable({...})
    packet.Source = source
    spawn(function()
        wait(10)
        packet:Destroy()
    end)
    return packet
end

function PluginNetworkClient.fireClient(_, client, ...)
    local packet = PluginNetworkClient:createPacket(...)
    packet.Name = "Client"
    local from = Instance.new("ObjectValue")
    from.Name = "from"
    from.Value = player
    from.Parent = packet
    local to = Instance.new("ObjectValue")
    to.Name = "to"
    to.Value = client
    to.Parent = packet
    packet.Parent = packetFolder
end


function PluginNetworkClient.fireAllClients(_, ...)
    local packet = PluginNetworkClient:createPacket(...)
    local from = Instance.new("ObjectValue")
    from.Name = "from"
    from.Value = player
    from.Parent = packet
    local received = Instance.new("Folder")
    received.Name = "received"
    received.Parent = packet
    packet.Parent = packetFolder
end

function PluginNetworkClient.onClientEvent(_, callback)
    local index = #clientEvents + 1
    clientEvents[index] = callback
    return index
end

function PluginNetworkClient.removeClientEvent(_, index)
    table.remove(clientEvents, index)
end

return PluginNetworkClient