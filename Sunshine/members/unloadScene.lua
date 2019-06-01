return function(Sunshine)
    if Sunshine.scene then
        Sunshine.updateCallbacks = {}
        for _, connection in pairs(Sunshine.connections) do
            connection:Disconnect()
        end
        for _, instance in pairs(Sunshine.instances) do
            instance:Destroy()
        end
        for _,p in pairs(game.SoundService:GetChildren()) do
			if p:IsA("Sound") then
				p:Destroy()
			end
		end
        Sunshine.dataScene = nil
        Sunshine.scene = nil
    end
end