return function(Sunshine, entity)
    local widget = entity.widget
    if widget then
        widget.widget = Sunshine.plugin:CreateDockWidgetPluginGui(entity.core.id,
        DockWidgetPluginGuiInfo.new(widget.dockState, widget.enabled, widget.overrideEnabledRestore, widget.size.X,
        widget.size.Y, widget.minSize.X, widget.minSize.Y))
        widget.widget.Title = widget.title
        widget.widget.Name = entity.core.id
        Sunshine:update(function()
            widget.widget.Enabled = widget.enabled
        end, entity)
    end
end