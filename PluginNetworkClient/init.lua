local PluginNetworkClient = {}

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
    return packet
end

function PluginNetworkClient.fireClient(_, client, ...)
    local packet = PluginNetworkClient:createPacket(...)
    print(packet.Source)
end


function PluginNetworkClient.fireAllClients(_, ...)
    local packet = PluginNetworkClient:createPacket(...)
    print(packet.Source)
end

function PluginNetworkClient.onClientEvent(_, callback)
    -- callback(client, ...)
end

return PluginNetworkClient