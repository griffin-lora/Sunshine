return function(Sunshine, orig, copies)
    copies = copies or {}
    local orig_type = type(orig)
    local copy
    if orig_type == 'table' then
        if copies[orig] then
            copy = copies[orig]
        else
            copy = {}
            for orig_key, orig_value in next, orig, nil do
                copy[Sunshine:cloneTable(orig_key, copies)] = Sunshine:cloneTable(orig_value, copies)
            end
            copies[orig] = copy
            setmetatable(copy, Sunshine:cloneTable(getmetatable(orig), copies))
        end
    else
        copy = orig
    end
    return copy
end