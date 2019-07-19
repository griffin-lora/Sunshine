--this is only temporary

local collectionService = game:GetService("CollectionService")
local normalTexture = "rbxassetid://3490352235"
local midBlinkTexture = "rbxassetid://3495832412"
local blinkTexture = "rbxassetid://3495833484"

return function(Sunshine, entity, scene)
    local player = entity.player
    local waitTime = math.random(2.5, 4.5)
    local timeSince = Sunshine:tick(scene)
    
    if player then
        local mainCharacter = Sunshine:getEntity(player.mainCharacter, scene)
        if mainCharacter then
            local model = mainCharacter.model
            Sunshine:update(function()
                if player.character == player.mainCharacter then
                    for _, p in pairs(model.model:GetDescendants()) do
                        if collectionService:HasTag(p, "face") then
                            if Sunshine:tick(scene) - timeSince > waitTime then
                                timeSince = Sunshine:tick(scene)
                                waitTime = math.random(2.5,4.5)
                                p.Texture = midBlinkTexture
                                p.Texture = normalTexture
                            end
                        end
                    end
                end
            end, entity)
        end
    end
end