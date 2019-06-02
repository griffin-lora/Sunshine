return function(Sunshine, scene)
	for _,p in pairs(game.SoundService:GetChildren()) do
		if p:IsA("Sound") then
			p.Volume = 0
		end
	end
end