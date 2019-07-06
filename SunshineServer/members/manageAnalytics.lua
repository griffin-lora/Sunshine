local RunService = game:GetService("RunService")

return function()
    if not RunService:IsStudio() and game.ServerScriptService:FindFirstChild("trackingId") then
        local trackingId = require(game.ServerScriptService.trackingId)
        local config = {
            DoNotReportScriptErrors = false,
            DoNotTrackServerStart = false,
            DoNotTrackVisits = false
        }
        local Analytics = require(153590792)
        Analytics.Init(trackingId, config)
    elseif not game.ServerScriptService:FindFirstChild("trackingId") then
        warn("Google Analytics is not enabled due to no tracking id being found.")
    end
end