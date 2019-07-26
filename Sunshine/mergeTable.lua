return function(Sunshine, mainTable, mergeTable)
    local mergedTable = Sunshine:cloneTable(mainTable)
    for key, value in pairs(mergeTable) do
        if not mergedTable[key] then
            mergedTable[key] = value
        end
    end
    return mergedTable
end