return function(Sunshine, ...)
    warn("DEPRECATED_WARN: Sunshine:copyTable is deprecated. Please use cloneTable.")
    Sunshine:cloneTable(...)
end