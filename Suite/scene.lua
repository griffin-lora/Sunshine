return {entities = {
    --Widgets
    {
        core = {
            id = "{3E798C2C-B6C6-4E73-BF9A-7DAFD0B4473F}",
            name = "LoadSceneWidget",
            active = true
        },
        widget = {
            title = "Manage Scenes",
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
    --Scene Loader
    {
        core = {
            id = "{0CB50030-50BA-4A0D-A80C-0E607F52C8D5}",
            name = "LoadSceneButton",
            active = true
        },
        uiTransform = {
            position = UDim2.new(0.5, 0, 0.35, 0),
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
            size = UDim2.new(0.6, 0, 0.2, 0),
            text = "Load Scene",
            textColor = Color3.fromRGB(69, 189, 117),
            font = "GothamBlack"
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
            position = UDim2.new(0.5, 0, 0.65, 0),
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
            size = UDim2.new(0.6, 0, 0.2, 0),
            text = "Save Scene",
            textColor = Color3.fromRGB(0, 135, 200),
            font = "GothamBlack"
        },
        saver = {}
    },
    {
        core = {
            id = "{949bca1d-e16f-4125-a4a3-7997ff0f3f5e}",
            name = "SceneManagerBackground",
            active = true
        },
        uiTransform = {
            position = UDim2.new(0, 0, 0, 0),
            size = Vector2.new(1, 1),
            rotation = 0,
            zIndex = -1,
            anchorPoint = Vector2.new(0, 0)
        },
        frame = {
            frame = script.Parent.frames.backgroundGreen
        },
        scroller = {
            axis = "xy",
            amount = 75,
            tweenInfo = TweenInfo.new(1, Enum.EasingStyle.Linear, Enum.EasingDirection.Out, -1, false, 0)
        },
        parent = {
            parent = "{3E798C2C-B6C6-4E73-BF9A-7DAFD0B4473F}"
        },
    },
    --Component Editor
    {
        core = {
            id = "{5cf0ec08-06d3-43e6-bfaf-34ebebb192e7}",
            name = "CompEditorBackground",
            active = true
        },
        uiTransform = {
            position = UDim2.new(0, 0, 0, 0),
            size = Vector2.new(1, 1),
            rotation = 0,
            zIndex = -1,
            anchorPoint = Vector2.new(0, 0)
        },
        frame = {
            frame = script.Parent.frames.backgroundRed
        },
        scroller = {
            axis = "xy",
            amount = 75,
            tweenInfo = TweenInfo.new(1, Enum.EasingStyle.Linear, Enum.EasingDirection.Out, -1, false, 0)
        },
        parent = {
            parent = "{BC51A2F2-3163-4DF7-95BA-68750BA7B7CF}"
        },
    },
    {
        core = {
            id = "{3779b6e0-4235-402a-8fe6-146e7dbd5bbd}",
            name = "CompEditorFrame",
            active = true
        },
        uiTransform = {
            position = UDim2.new(0, 0, 0, 0),
            size = Vector2.new(1, 1),
            rotation = 0,
            zIndex = 0,
            anchorPoint = Vector2.new(0, 0)
        },
        frame = {
            frame = script.Parent.frames.blank
        },
        parent = {
            parent = "{BC51A2F2-3163-4DF7-95BA-68750BA7B7CF}"
        },
    },
    {
        core = {
            id = "{084886b2-5de6-4566-b31f-79a57f736fa0}",
            name = "CompEditorSelected",
            active = true
        },
        uiTransform = {
            position = UDim2.new(0.5, 0, 0.05, 0),
            size = Vector2.new(1, 1),
            rotation = 0,
            zIndex = 1,
            anchorPoint = Vector2.new(0.5, 0)
        },
        label = {
            text = "No entity selected!",
            color = Color3.new(1, 1, 1),
            outlineTransparency = 1,
            outlineColor = Color3.new(0, 0, 0),
            size = UDim2.new(0.8, 0, 0.1, 0),
            font = "GothamBold"
        },
        tag = {
            tag = "entitySelectedText"
        },
        parent = {
            parent = "{3779b6e0-4235-402a-8fe6-146e7dbd5bbd}"
        },
    },
--Other
    {
        core = {
            id = "{27331DC5-098F-4C08-807A-11A6A4B0AC2B}",
            name = "ScnChangeManager",
            active = true
        },
        change = {
        },
        teamCreate = {
        },
        history = {
        },
        tag = {
            "changeManager"
        }
    },
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