--this code was copy-pasted

return function(Sunshine, string)
   return (string):gsub(".%f[%l]", " %1"):gsub("%l%f[%u]", "%1 "):gsub("^.", string.upper)
end