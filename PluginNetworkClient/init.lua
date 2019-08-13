local PluginNetworkClient = {}
local clientEvents = {}
local player = game:GetService("Players").LocalPlayer
if not player:FindFirstChild("usingPNC") then
    local usingPNC = Instance.new("BoolValue")
    usingPNC.Name = "usingPNC"
    usingPNC.Parent = player
end
local packetFolder = game:GetService("ServerStorage"):FindFirstChild("PNCPacketFolder") or Instance.new("Folder")
packetFolder.Name = "PNCPacketFolder"
packetFolder.Parent = game:GetService("ServerStorage")
packetFolder.ChildAdded:Connect(function(packet)
    if packet.from.Value ~= player then
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

function PluginNetworkClient.createPacket(_, ...)
    local packet = Instance.new("ModuleScript")
    local source = "return {"
    for index, argument in ipairs({...}) do
        source = source .. "[" .. index .. "]="
        if typeof(argument) == "number" then
            source = source .. tostring(argument)
        elseif typeof(argument) == "string" then
            source = source .. "\"" .. argument .. "\""
        elseif typeof(argument) == "Instance" then
            source = source .. "game." .. argument:GetFullName()
        else
            error("Type " .. typeof(argument) .. " is not supported.")
        end
        source = source .. ","
    end
    source = source .. "}"
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