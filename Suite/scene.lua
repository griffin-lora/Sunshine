return {entities = {
    --Widgets
    {
        core = {
            id = "{3E798C2C-B6C6-4E73-BF9A-7DAFD0B4473F}",
            name = "UtilWidget",
            active = true
        },
        widget = {
            title = "Utility",
            dockState = Enum.InitialDockState.Right,
            enabled = true,
            overrideEnabledRestore = true,
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
            overrideEnabledRestore = true,
            size = Vector2.new(400, 500),
            minSize = Vector2.new(300, 80)
        },
        componentEditor = {
            components = {
                core = {
                    active = {type = "boolean", default = true},
                    name = {type = "string", default = "Name"}
                },
                prefab = {
                    prefab = {type = "Instance", default = nil}
                },
                model = {
                    model = {type = "Instance", default = nil}
                },
                transform = {
                    cFrame = {type = "CFrame", default = CFrame.new()},
                    size = {type = "Vector3", default = Vector3.new(1, 1, 1)}
                },
                physics = {
                    anchored = {type = "boolean", default = true},
                    canCollide = {type = "boolean", default = true},
                    welded = {type = "boolean", default = true},
                    massless = {type = "boolean", default = false},
                    velocity = {type = "Vector3", default = Vector3.new()},
                    angularVelocity = {type = "Vector3", default = Vector3.new()},
                    density = {type = "number", default = 0.7},
                    friction = {type = "number", default = 0.3},
                    elasticity = {type = "number", default = 0.5},
                    frictionWeight = {type = "number", default = 1},
                    elasticityWeight = {type = "number", default = 1},
                    movable = {type = "boolean", default = true},
                },
                tag = {
                    tag = {type = "string", default = ""}
                },
                collider = {
                    trigger = {type = "boolean", default = false},
                    anchored = {type = "boolean", default = false}
                },
                collectible = {
                },
                input = {
                    moveVector = {type = "Vector3", default = Vector3.new()},
                    space = {type = "boolean", default = false},
                    shift = {type = "boolean", default = false},
                    camera = {type = "Entity", default = nil},
                },
                character = {
                    controllable = {type = "boolean", default = false},
                    canLoseMagnitude = {type = "boolean", default = false},
                    -- shirtGraphic = {type = "string", default = ""},
                    -- shirtGraphicColor = {type = "Color3", default = Color3.fromRGB(255, 255, 255)},
                    -- shirt = {type = "string", default = ""},
                    -- shirtColor = {type = "Color3", default = Color3.fromRGB(255, 255, 255)},
                    -- pants = {type = "string", default = ""},
                    -- pantsColor = {type = "Color3", default = Color3.fromRGB(255, 255, 255)},
                    -- headColor = {type = "Color3", default = Color3.fromRGB(163, 162, 165)},
                    -- leftArmColor = {type = "Color3", default = Color3.fromRGB(163, 162, 165)},
                    -- leftLegColor = {type = "Color3", default = Color3.fromRGB(163, 162, 165)},
                    -- rightArmColor = {type = "Color3", default = Color3.fromRGB(163, 162, 165)},
                    -- rightLegColor = {type = "Color3", default = Color3.fromRGB(163, 162, 165)},
                    -- torsoColor = {type = "Color3", default = Color3.fromRGB(163, 162, 165)},
                    walkSpeed = {type = "number", default = 16},
                    walkSpeedFactor = {type = "number", default = 1},
                    moveAnimation = {type = "number", default = 0},
                    idleAnimation = {type = "number", default = 0},
                    fallAnimation = {type = "number", default = 0},
                    swimAnimation = {type = "number", default = 0},
                    sinkAnimation = {type = "number", default = 0},
                },
                charData = {
                    coins = {type = "number", default = 0}
                },
                stats = {
                    coins = {type = "number", default = 0},
                    regionalCoins = {type = "number", default = 0}
                },
                jump = {
                    power = {type = "number", default = 50},
                    animation = {type = "number", default = 0},
                    sound = {type = "number", default = 0}
                },
            
                dive = {
                    power = {type = "number", default = 50},
                    bouncePower = {type = "number", default = 50},
                    animation = {type = "number", default = 0},
                    doAnimation = {type = "number", default = 0},
                    endAnimation = {type = "number", default = 0},
                    sound = {type = "number", default = 0}
                },
                camera = {
                    controllable = {type = "boolean", default = false},
                    subject = {type = "Entity", default = nil},
                    fieldOfView = {type = "number", default = 70},
                    rotateSpeed = {type = "number", default = 0.5},
                    scrollSpeed = {type = "number", default = 5},
                    maxZoom = {type = "number", default = 40},
                    minZoom = {type = "number", default = 10},
                    lerpSpeed = {type = "number", default = 15}
                },
                spinner = {
                    speed = {type = "number", default = 1},
                    axis = {type = "string", default = "y"}
                },
                animator = {
                },
                frame = {
                    frame = {type = "Instance", default = nil}
                },
                uiTransform = {
                    position = {type = "UDim2", default = UDim2.new()},
                    size = {type = "Vector2", default = Vector2.new(1, 1)},
                    zIndex = {type = "number", default = 0},
                    anchorPoint = {type = "Vector2", default = Vector2.new()},
                },
                label = {
                    text = {type = "string", default = "label"},
                    size = {type = "UDim2", default = UDim2.new(0, 100, 0, 100)},
                    color = {type = "Color3", default = Color3.new(1, 1, 1)},
                    -- font = {type = Enum.Font, default = Enum.Font.Highway}
                },
                button = {
                    activated = {type = "boolean", default = false},
                    size = {type = "UDim2", default = UDim2.new(0, 100, 0, 100)}
                },
                sound = {
                    id = {type = "number", default = 0},
                    playing = {type = "boolean", default = false},
                    volume = {type = "number", default = 0.5},
                },
                animation = {
                    id = {type = "number", default = 0},
                    looped = {type = "boolean", default = false},
                    playing = {type = "boolean", default = false},
                    speed = {type = "number", default = 1}
                },
                transparency = {
                    transparency = {type = "number", default = 0}
                },
            
                lighting = {
                    sky = {type = "Instance", default = nil},
                    lightness = {type = "number", default = 2},
                    ambient = {type = "Color3", default = Color3.fromRGB(128, 128, 128)},
                    outdoorAmbient = {type = "Color3", default = Color3.fromRGB(128, 128, 128)},
                    globalShadows = {type = "boolean", default = true},
                    clockTime = {type = "number", default = 12},
                    sunPos = {type = "number", default = 41},
                    fogColor = {type = "Color3", default = Color3.fromRGB(192, 192, 192)},
                    fogStart = {type = "number", default = 0},
                    fogEnd = {type = "number", default = 100000},
                    brightness = {type = "number", default = 0},
                    contrast = {type = "number", default = 0},
                    saturation = {type = "number", default = 0},
                    tintColor = {type = "Color3", default = Color3.new(1,1,1)},
                    blurAmount = {type = "number", default = 0},
                    bloomThreshold = {type = "number", default = 2},
                    sunRays = {type = "boolean", default = false},
                    sunIntensity = {type = "number", default = 0.25}
                },
                crouch = {
                    walkSpeedFactor = {type = "number", default = 0.5},
                    animation = {type = "number", default = 0},
                    moveAnimation = {type = "number", default = 0},
                    sound = {type = "number", default = 0}
                },
                groundPound = {
                    walkSpeedFactor = {type = "number", default = 0.1},
                    speed = {type = "number", default = 50},
                    delay = {type = "number", default = 0.5},
                    startAnimation = {type = "number", default = 0},
                    animation = {type = "number", default = 0},
                    endAnimation = {type = "number", default = 0},
                    sound = {type = "number", default = 0},
                    endSound = {type = "number", default = 0}
                },
                groundPoundJump = {
                    power = {type = "number", default = 50},
                    animation = {type = "number", default = 0},
                    sound = {type = "number", default = 0}
                },
                backFlip = {
                    power = {type = "number", default = 50},
                    backPower = {type = "number", default = 50},
                    animation = {type = "number", default = 0},
                    sound = {type = "number", default = 0}
                },
                longJump = {
                    power = {type = "number", default = 50},
                    bouncePower = {type = "number", default = 50},
                    animation = {type = "number", default = 0},
                    sound = {type = "number", default = 0}
                },
                store = {
                },
                moving = {
                    extend = {type = "CFrame", default = CFrame.new(0,0,0)},
                    speed = {type = "number", default = 1}
                },
                head = {
                    character = {type = "Entity", default = nil},
                    time = {type = "number", default = 2},
                    holdTime = {type = "number", default = 5},
                    bounceTime = {type = "number", default = 0.5},
                },
            
                bouncer = {
                    power = {type = "number", default = 50},
                    direct = {type = "boolean", default = false}
                },
            
                teleporter = {
                    scene = {type = "Instance", default = nil}
                },
            
                throw = {
                    power = {type = "number", default = 50},
                    distance = {type = "number", default = 20},
                    animation = {type = "number", default = 0},
                    head = {type = "Entity", default = nil},
                    sound = {type = "number", default = 0}
                },
            
                health = {
                    health = {type = "number", default = 3},
                    time = {type = "number", default = 2},
                    invulnerabilityFrames = {type = "boolean", default = true},
                },
            
                bounce = {
                    power = {type = "number", default = 50},
                    animation = {type = "number", default = 0},
                    bounceCount = {type = "number", default = 0},
                    sound = {type = "number", default = 0}
                },
                capture = {
                    active = {type = "boolean", default = false},
                    character = {type = "Entity", default = nil}
                },
            
                lockAxis = {
                    x = {type = "boolean", default = false},
                    y = {type = "boolean", default = false},
                    z = {type = "boolean", default = false}
                },
                coin = {
                    tweenInfo = {type = "TweenInfo", default = TweenInfo.new()}
                },
                regionalCoin = {
                    tweenInfo = {type = "TweenInfo", default = TweenInfo.new()}
                },
            
                coinCounter = {
                    player = {type = "Entity", default = nil}
                },
                deathBarrier = {
                    y = {type = "number", default = -500}
                },
            
                wallPush = {
                    animation = {type = "number", default = 0}
                },
                wallSlide = {
                    animation = {type = "number", default = 0},
                    speed = {type = "number", default = -50},
                },
            
                wallJump = {
                    animation = {type = "number", default = 0},
                    power = {type = "number", default = 5},
                    bouncePower = {type = "number", default = 20},
                    sound = {type = "number", default = 0}
                },
                hazard = {
                    damage = {type = "number", default = 1}
                },
            
                player = {
                    mainCharacter = {type = "Entity", default = nil},
                    character = {type = "Entity", default = nil},
                    camera = {type = "Entity", default = nil}
                },
                doubleJump = {
                    power = {type = "number", default = 50},
                    animation = {type = "number", default = 0},
                    sound = {type = "number", default = 0},
                    time = {type = "number", default = 0.7}
                },
                tripleJump = {
                    power = {type = "number", default = 50},
                    animation = {type = "number", default = 0},
                    sound = {type = "number", default = 0},
                    time = {type = "number", default = 0.7}
                },
                follow = {
                    range = {type = "number", default = 50},
                    radius = {type = "number", default = 70},
                    active = {type = "boolean", default = true}
                },
                spawner = {
                    active = {type = "boolean", default = false},
                    entity = {type = "Entity", default = nil}
                },
                collisionSpawner = {
                },
                crate = {
                    hits = {type = "number", default = 1}
                },
            
                sceneTransition = {
                    tweenInfo = {type = "TweenInfo", default = TweenInfo.new()}
                },
            
                visible = {
                    visible = {type = "boolean", default = true},
                },
            
                spawn = {
                    active = {type = "boolean", default = false}
                },
                checkpoint = {
                },
                magicMirror = {
                    preview = {type = "number", default = 0},
                    active = {type = "boolean", default = false},
                },
                terrain = {
                    -- material = {type = Enum.Material, default = Enum.Material.Grass}
                },
                water = {
            
                },
                swimUp = {
                    power = {type = "number", default = 50},
                    animation = {type = "number", default = 0},
                    sound = {type = "number", default = 0}
                },
                music = {
                    id = {type = "number", default = 0},
                    volume = {type = "number", default = 1},
                    paused = {type = "boolean", default = false},
                },
                scriptCollectible = {
                    name = {type = "string", default = "rename this or you\'re a poo poo head"},
                    active = {type = "boolean", default = false}
                },
                pause = {},
                oscillator = {
                    amplitude = {type = "number", default = 1},
                    frequency = {type = "number", default = 1},
                    axis = {type = "string", default = "y"}
                },
                lockRotationAxis = {
                    x = {type = "boolean", default = false},
                    y = {type = "boolean", default = false},
                    z = {type = "boolean", default = false}
                },
                cracked = {
                    time = {type = "number", default = 2},
                    instant = {type = "boolean", default = false},
                    respawn = {type = "boolean", default = true},
                    animation = {type = "number", default = 0},
                },
                dash = {
                    animation = {type = "number", default = 0},
                    factor = {type = "number", default = 3},
                    time = {type = "number", default = 3}
                },
                respawner = {
                    active = {type = "boolean", default = false},
                    time = {type = "number", default = 0}
                },
                scriptCollectibleDisplay = {
                },
                key = {
                    scriptCollectible = {type = "Entity", default = nil},
                    active = {type = "boolean", default = false}
                },
                gyroBlock = {
                    hits = {type = "number", default = 2},
                    ring1 = {type = "Entity", default = nil},
                    ring2 = {type = "Entity", default = nil},
                },
            
                crackedWall = {
                    animation =  {type = "number", default = 0},
                    time = {type = "number", default = 0}
                },
                hydrophobic = {
                },
                bonk = {
                    power = {type = "number", default = 20},
                    animation = {type = "number", default = 0},
                    sound = {type = "number", default = 0}
                },
                gravity = {
                    ignore = {type = "boolean", default = true}
                },
                parent = {
                    parent = {type = "Entity", default = nil}
                },
                healthUI = {
                    player = {type = "Entity", default = nil},
                    image = {type ="number", default = 2324645164},
                    rectOffset3 = {type = "Vector2", default = Vector2.new()},
                    rectOffset2 = {type = "Vector2", default = Vector2.new()},
                    rectOffset1 = {type = "Vector2", default = Vector2.new()},
                    rectOffset0 = {type = "Vector2", default = Vector2.new()}
                },
                speaker = {
                    id = {type = "number", default = 0},
                    playing = {type = "boolean", default = false},
                    volume = {type = "number", default = 1},
                },
                swingingUprightPlatform = {
                    speed = {type = "number", default = 2},
                    range = {type = "number", default = 45},
                },
                musicTracker = {
                    entity = {type = "Entity", default = nil},
                },
                inertia = {},
                gameVisible = {}
            }
        }
    },
    --Scene Loader
    {
        core = {
            id = "{0CB50030-50BA-4A0D-A80C-0E607F52C8D5}",
            name = "LoadSceneButton",
            active = true
        },
        uiTransform = {
            position = UDim2.new(0.5, 0, 0.5, 0),
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
    -- {
    --     core = {
    --         id = "{CBF6F8AB-8358-4ED6-AACC-13BF1BECB567}",
    --         name = "SaveSceneButton",
    --         active = true
    --     },
    --     uiTransform = {
    --         position = UDim2.new(0.5, 0, 0.65, 0),
    --         size = Vector2.new(1, 1),
    --         rotation = 0,
    --         zIndex = 0,
    --         anchorPoint = Vector2.new(0.5, 0.5)
    --     },
    --     frame = {
    --         frame = script.Parent.frames.button
    --     },
    --     parent = {
    --         parent = "{3E798C2C-B6C6-4E73-BF9A-7DAFD0B4473F}"
    --     },
    --     button = {
    --         size = UDim2.new(0.6, 0, 0.2, 0),
    --         text = "Save Scene",
    --         textColor = Color3.fromRGB(0, 135, 200),
    --         font = "GothamBlack"
    --     },
    --     saver = {}
    -- },
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
        }
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
        }
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
        }
    },
    {
        core = {
            id = "{084886b2-5de6-4566-b31f-79a57f736fa0}",
            name = "CompEditorSelected",
            active = true
        },
        uiTransform = {
            position = UDim2.new(0.5, 0, 0.03, 0),
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
        }
    },
    {
        core = {
            id = "{7419E0EF-4D76-47C8-92B1-09F38E8A8F36}",
            name = "ScrollingFrame",
            active = true
        },
        uiTransform = {
            position = UDim2.new(1, 5, 0.5, 0),
            size = Vector2.new(1, 1),
            rotation = 0,
            zIndex = 1,
            anchorPoint = Vector2.new(1, 0.5)
        },
        scrollingFrame = {
            size =  UDim2.new(1,-5,0.65,0),
            canvasSize = UDim2.new(0,0,0,0),
            scrollingDirection = "Y",
            frame = nil,
        },
        tag = {
            tag = "componentsFrame"
        },
        visible = {
            visible = true
        },
        parent = {
            parent = "{3779b6e0-4235-402a-8fe6-146e7dbd5bbd}"
        }
    },
    {
        core = {
            id = "{CACF2305-D309-41E9-AA7C-2BC4E518B7F3}",
            name = "ComponentBackButton",
            active = true
        },
        uiTransform = {
            position = UDim2.new(0.5, 0, 1, -5),
            size = Vector2.new(1, 1),
            rotation = 0,
            zIndex = 0,
            anchorPoint = Vector2.new(0.5, 1)
        },
        frame = {
            frame = script.Parent.frames.button
        },
        parent = {
            parent = "{3779b6e0-4235-402a-8fe6-146e7dbd5bbd}"
        },
        visible = {
            visible = false
        },
        button = {
            size = UDim2.new(0.9, 0, 0.15, 0),
            text = "Back",
            textColor = Color3.fromRGB(0, 0, 0),
            font = "GothamBold"
        },
        tag = {
            tag = "componentBackButton"
        }
    },
        {
        core = {
            id = "{D74A2253-35CD-4921-99C5-3A3F775A3F24}",
            name = "focusedComponentFrame",
            active = true
        },
        uiTransform = {
            position = UDim2.new(1, 0, 0.5, 0),
            size = Vector2.new(1, 1),
            rotation = 0,
            zIndex = 1,
            anchorPoint = Vector2.new(1, 0.5)
        },
        frame = {
            frame = script.Parent.frames.focusedComponentFrame
        },
        tag = {
            tag = "focusedComponentFrame"
        },
        visible = {
            visible = false
        },
        parent = {
            parent = "{3779b6e0-4235-402a-8fe6-146e7dbd5bbd}"
        }
    },
    {
        core = {
            id = "{8465CE6D-CB7D-4779-8BFE-0AA1C205E188}",
            name = "focusedComponentScrollingFrame",
            active = true
        },
        uiTransform = {
            position = UDim2.new(0, 5, 1, 0),
            size = Vector2.new(1, 1),
            rotation = 0,
            zIndex = 1,
            anchorPoint = Vector2.new(0, 1)
        },
        scrollingFrame = {
            size =  UDim2.new(1, -5, 0.85, 0),
            canvasSize = UDim2.new(0, 0, 2, 0),
            scrollingDirection = "Y",
            frame = nil,
        },
        tag = {
            tag = "focusedComponentScrollingFrame"
        },
        visible = {
            visible = true
        },
        uiListLayout = {
            padding = UDim.new(0, 5),
            instance = nil
        },
        parent = {
            parent = "{D74A2253-35CD-4921-99C5-3A3F775A3F24}"
        }
    },
--changemanager
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
            tag = "changeManager"
        }
    },
}}