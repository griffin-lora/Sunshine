return function(Sunshine, ...)
    warn("Sunshine:sceneLoad is deprecated. The closest implementation you can use Sunshine:sceneUnload")
    Sunshine:sceneUnload(...)
end