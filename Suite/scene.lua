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
            id = "{BC51A2F2-3163-4DF7-95BA-68750BA7B7CF}",
            name = "CompEditWidget",
            active = true
        },
        widget = {
            title = "Component Editor",
            dockState = Enum.InitialDockState.Left,
            enabled = true,
            overrideEnabledRestore = false,
            size = Vector2.new(400, 500),
            minSize = Vector2.new(300, 80)
        },
        componentEditor = {}
    },
    {
        core = {
            id = "{0CB50030-50BA-4A0D-A80C-0E607F52C8D5}",
            name = "LoadSceneButton",
            active = true
        },
        uiTransform = {
            position = UDim2.new(0, 0, 0, 0),
            size = Vector2.new(1, 1),
            rotation = 0,
            zIndex = 0,
            anchorPoint = Vector2.new(0.5, 0.5)
        },
        frame = {
            frame = script.Parent.frames.button
        },
        parent = {
            parent = "{3E798C2C-B6C6-4E73-BF9A-7DAFD0B4473F}"
        },
        button = {
            size = UDim2.new(0.2, 0, 0.1, 0)
        },
        loader = {}
    },
    {
        core = {
            id = "{CBF6F8AB-8358-4ED6-AACC-13BF1BECB567}",
            name = "SaveSceneButton",
            active = true
        },
        uiTransform = {
            position = UDim2.new(0, 0, 0.3, 0),
            size = Vector2.new(1, 1),
            rotation = 0,
            zIndex = 0,
            anchorPoint = Vector2.new(0.5, 0.5)
        },
        frame = {
            frame = script.Parent.frames.button
        },
        parent = {
            parent = "{3E798C2C-B6C6-4E73-BF9A-7DAFD0B4473F}"
        },
        button = {
            size = UDim2.new(0.2, 0, 0.1, 0)
        },
        saver = {}
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