return function(Sunshine, mainTable, mergeTable)
    local mergedTable = Sunshine:copyTable(mainTable)
    for key, value in pairs(mergeTable) do
        if not mergedTable[key] then
            mergedTable[key] = value
        end
    end
    return mergedTable
end