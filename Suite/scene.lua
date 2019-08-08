return {entities = {
    {
        core = {
            id = "{3E798C2C-B6C6-4E73-BF9A-7DAFD0B4473F}",
            name = "LoadSceneWidget",
            active = true
        },
        widget = {
            title = "Load Scene",
            dockState = Enum.InitialDockState.Right,
            enabled = true,
            overrideEnabledRestore = false,
            size = Vector2.new(400, 500),
            minSize = Vector2.new(300, 80)
        }
    },
    {
        core = {
            id = "{0CB50030-50BA-4A0D-A80C-0E607F52C8D5}",
            name = "LoadSceneButton",
            active = true
        },
        uiTransform = {
            position = UDim2.new(0, 0, 0, 0),
            size = Vector2.new(1, 1)
        },
        frame = {
            frame = script.Parent.frames.button
        },
        parent = {
            parent = "{3E798C2C-B6C6-4E73-BF9A-7DAFD0B4473F}"
        },
        button = {},
        loader = {}
    }
}}

--[[
    {
        core = {
            id = "{3E798C2C-B6C6-4E73-BF9A-7DAFD0B4473F}",
            name = "DataStore",
            active = true
        },
        store = {}
    }
]]