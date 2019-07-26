local GuiService = game:GetService("GuiService")

return function(Sunshine)
    GuiService.MenuOpened:Connect(function()
        Sunshine.running = false
    end)
    GuiService.MenuClosed:Connect(function()
        Sunshine.running = true
    end)
end