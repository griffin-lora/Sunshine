return {
	core = {
		active = {Type = "boolean", Default = true},
		name = {Type = "string", Default = "Name"}
	},
	prefab = {
		prefab = {Type = "Instance", Default = nil}
	},
	model = {
		model = {Type = "Instance", Default = nil}
	},
	transform = {
		cFrame = {Type = "CFrame", Default = CFrame.new()},
		size = {Type = "Vector3", Default = Vector3.new(1, 1, 1)}
	},
	physics = {
		anchored = {Type = "boolean", Default = true},
		canCollide = {Type = "boolean", Default = true},
		welded = {Type = "boolean", Default = true},
		massless = {Type = "boolean", Default = false},
		velocity = {Type = "Vector3", Default = Vector3.new()},
		angularVelocity = {Type = "Vector3", Default = Vector3.new()},
		density = {Type = "number", Default = 0.7},
		friction = {Type = "number", Default = 0.3},
		elasticity = {Type = "number", Default = 0.5},
		frictionWeight = {Type = "number", Default = 1},
		elasticityWeight = {Type = "number", Default = 1},
		movable = {Type = "boolean", Default = true},
	},
	tag = {
		tag = {Type = "string", Default = ""}
	},
	collider = {
        trigger = {Type = "boolean", Default = false},
        anchored = {Type = "boolean", Default = false}
	},
	collectible = {
	},
	input = {
		moveVector = {Type = "Vector3", Default = Vector3.new()},
		space = {Type = "boolean", Default = false},
        shift = {Type = "boolean", Default = false},
        camera = {Type = "Object", Default = nil},
	},
	character = {
		controllable = {Type = "boolean", Default = false},
		canLoseMagnitude = {Type = "boolean", Default = false},
		-- shirtGraphic = {Type = "string", Default = ""},
		-- shirtGraphicColor = {Type = "Color3", Default = Color3.fromRGB(255, 255, 255)},
		-- shirt = {Type = "string", Default = ""},
		-- shirtColor = {Type = "Color3", Default = Color3.fromRGB(255, 255, 255)},
		-- pants = {Type = "string", Default = ""},
		-- pantsColor = {Type = "Color3", Default = Color3.fromRGB(255, 255, 255)},
		-- headColor = {Type = "Color3", Default = Color3.fromRGB(163, 162, 165)},
		-- leftArmColor = {Type = "Color3", Default = Color3.fromRGB(163, 162, 165)},
		-- leftLegColor = {Type = "Color3", Default = Color3.fromRGB(163, 162, 165)},
		-- rightArmColor = {Type = "Color3", Default = Color3.fromRGB(163, 162, 165)},
		-- rightLegColor = {Type = "Color3", Default = Color3.fromRGB(163, 162, 165)},
		-- torsoColor = {Type = "Color3", Default = Color3.fromRGB(163, 162, 165)},
		walkSpeed = {Type = "number", Default = 16},
		walkSpeedFactor = {Type = "number", Default = 1},
		moveAnimation = {Type = "number", Default = 0},
		idleAnimation = {Type = "number", Default = 0},
        fallAnimation = {Type = "number", Default = 0},
		swimAnimation = {Type = "number", Default = 0},
		sinkAnimation = {Type = "number", Default = 0},
	},
	charData = {
		coins = {Type = "number", Default = 0}
	},
	stats = {
		coins = {Type = "number", Default = 0},
		regionalCoins = {Type = "number", Default = 0}
	},
	jump = {
        power = {Type = "number", Default = 50},
		animation = {Type = "number", Default = 0},
		sound = {Type = "number", Default = 0}
	},

	dive = {
		power = {Type = "number", Default = 50},
		bouncePower = {Type = "number", Default = 50},
        animation = {Type = "number", Default = 0},
		endAnimation = {Type = "number", Default = 0},
		sound = {Type = "number", Default = 0}
	},
	camera = {
		controllable = {Type = "boolean", Default = false},
		subject = {Type = "Object", Default = nil},
        fieldOfView = {Type = "number", Default = 70},
        rotateSpeed = {Type = "number", Default = 0.5},
        scrollSpeed = {Type = "number", Default = 5},
        maxZoom = {Type = "number", Default = 40},
        minZoom = {Type = "number", Default = 10},
        lerpSpeed = {Type = "number", Default = 15}
	},
	spinner = {
		speed = {Type = "number", Default = 1},
		axis = {Type = "string", Default = "y"}
	},
	animator = {
	},
	frame = {
		frame = {Type = "Instance", Default = nil}
	},
	uiTransform = {
		position = {Type = "UDim2", Default = UDim2.new()},
		size = {Type = "Vector2", Default = Vector2.new(1, 1)},
		zIndex = {Type = "number", Default = 0},
		anchorPoint = {Type = "Vector2", Default = Vector2.new()},
	},
	label = {
		text = {Type = "string", Default = "label"},
        size = {Type = "UDim2", Default = UDim2.new(0, 100, 0, 100)},
        color = {Type = "Color3", Default = Color3.new(1, 1, 1)},
        -- font = {Type = Enum.Font, Default = Enum.Font.Highway}
	},
	button = {
		activated = {Type = "boolean", Default = false},
        size = {Type = "UDim2", Default = UDim2.new(0, 100, 0, 100)}
	},
	sound = {
		id = {Type = "number", Default = 0},
        playing = {Type = "boolean", Default = false},
		volume = {Type = "number", Default = 0.5},
	},
	animation = {
		id = {Type = "number", Default = 0},
		looped = {Type = "boolean", Default = false},
        playing = {Type = "boolean", Default = false},
        speed = {Type = "number", Default = 1}
	},
    transparency = {
        transparency = {Type = "number", Default = 0}
    },

	lighting = {
		sky = {Type = "Instance", Default = nil},
		lightness = {Type = "number", Default = 2},
		ambient = {Type = "Color3", Default = Color3.fromRGB(128, 128, 128)},
		outdoorAmbient = {Type = "Color3", Default = Color3.fromRGB(128, 128, 128)},
		globalShadows = {Type = "boolean", Default = true},
		clockTime = {Type = "number", Default = 12},
		sunPos = {Type = "number", Default = 41},
		fogColor = {Type = "Color3", Default = Color3.fromRGB(192, 192, 192)},
		fogStart = {Type = "number", Default = 0},
		fogEnd = {Type = "number", Default = 100000},
		brightness = {Type = "number", Default = 0},
		contrast = {Type = "number", Default = 0},
		saturation = {Type = "number", Default = 0},
		tintColor = {Type = "Color3", Default = Color3.new(1,1,1)},
		blurAmount = {Type = "number", Default = 0},
		bloomThreshold = {Type = "number", Default = 2},
		sunRays = {Type = "boolean", Default = false},
		sunIntensity = {Type = "number", Default = 0.25}
    },
    crouch = {
        walkSpeedFactor = {Type = "number", Default = 0.5},
        animation = {Type = "number", Default = 0},
		moveAnimation = {Type = "number", Default = 0},
		sound = {Type = "number", Default = 0}
    },
    groundPound = {
        walkSpeedFactor = {Type = "number", Default = 0.1},
        speed = {Type = "number", Default = 50},
        delay = {Type = "number", Default = 0.5},
        startAnimation = {Type = "number", Default = 0},
        animation = {Type = "number", Default = 0},
		endAnimation = {Type = "number", Default = 0},
		sound = {Type = "number", Default = 0},
		endSound = {Type = "number", Default = 0}
    },
	groundPoundJump = {
		power = {Type = "number", Default = 50},
		animation = {Type = "number", Default = 0},
		sound = {Type = "number", Default = 0}
	},
	backFlip = {
		power = {Type = "number", Default = 50},
		backPower = {Type = "number", Default = 50},
		animation = {Type = "number", Default = 0},
		sound = {Type = "number", Default = 0}
	},
	longJump = {
		power = {Type = "number", Default = 50},
		bouncePower = {Type = "number", Default = 50},
		animation = {Type = "number", Default = 0},
		sound = {Type = "number", Default = 0}
	},
    store = {
	},
	moving = {
		extend = {Type = "CFrame", Default = CFrame.new(0,0,0)},
		speed = {Type = "number", Default = 1}
    },
    head = {
        character = {Type = "Object", Default = nil},
        time = {Type = "number", Default = 2},
        holdTime = {Type = "number", Default = 5},
        bounceTime = {Type = "number", Default = 0.5},
    },

    bouncer = {
        power = {Type = "number", Default = 50},
        direct = {Type = "boolean", Default = false}
    },

    teleporter = {
        scene = {Type = "Instance", Default = nil}
    },

    throw = {
        power = {Type = "number", Default = 50},
        distance = {Type = "number", Default = 20},
        animation = {Type = "number", Default = 0},
		head = {Type = "Object", Default = nil},
		sound = {Type = "number", Default = 0}
    },

    health = {
		health = {Type = "number", Default = 3},
		time = {Type = "number", Default = 2},
		invulnerabilityFrames = {Type = "boolean", Default = true},
    },

    bounce = {
        power = {Type = "number", Default = 50},
        animation = {Type = "number", Default = 0},
		bounceCount = {Type = "number", Default = 0},
		sound = {Type = "number", Default = 0}
    },
    capture = {
        active = {Type = "boolean", Default = false},
        character = {Type = "Object", Default = nil}
    },

    lockAxis = {
        x = {Type = "boolean", Default = false},
        y = {Type = "boolean", Default = false},
        z = {Type = "boolean", Default = false}
	},
	coin = {
        tweenInfo = {Type = "TweenInfo", Default = TweenInfo.new()}
	},
	regionalCoin = {
        tweenInfo = {Type = "TweenInfo", Default = TweenInfo.new()}
	},

	coinCounter = {
		player = {Type = "Object", Default = nil}
    },
    deathBarrier = {
        y = {Type = "number", Default = -500}
    },

    wallPush = {
        animation = {Type = "number", Default = 0}
    },
    wallSlide = {
        animation = {Type = "number", Default = 0},
        speed = {Type = "number", Default = -50},
    },

    wallJump = {
        animation = {Type = "number", Default = 0},
        power = {Type = "number", Default = 5},
		bouncePower = {Type = "number", Default = 20},
		sound = {Type = "number", Default = 0}
    },
    hazard = {
        damage = {Type = "number", Default = 1}
    },

    player = {
        mainCharacter = {Type = "Object", Default = nil},
        character = {Type = "Object", Default = nil},
        camera = {Type = "Object", Default = nil}
    },
	doubleJump = {
        power = {Type = "number", Default = 50},
		animation = {Type = "number", Default = 0},
		sound = {Type = "number", Default = 0}
	},
	tripleJump = {
        power = {Type = "number", Default = 50},
		animation = {Type = "number", Default = 0},
		sound = {Type = "number", Default = 0}
    },
    follow = {
        range = {Type = "number", Default = 50},
        radius = {Type = "number", Default = 70},
        active = {Type = "boolean", Default = true}
    },
    spawner = {
        active = {Type = "boolean", Default = false},
        entity = {Type = "Object", Default = nil}
    },
    collisionSpawner = {
	},
	crate = {
		hits = {Type = "number", Default = 1}
	},

    sceneTransition = {
        tweenInfo = {Type = "TweenInfo", Default = TweenInfo.new()}
    },

    visible = {
        visible = {Type = "boolean", Default = true},
    },

    spawn = {
        active = {Type = "boolean", Default = false}
	},
    checkpoint = {
	},
    magicMirror = {
        preview = {Type = "number", Default = 0},
        active = {Type = "boolean", Default = false},
	},
    terrain = {
        -- material = {Type = Enum.Material, Default = Enum.Material.Grass}
	},
    water = {

	},
	swimUp = {
        power = {Type = "number", Default = 50},
		animation = {Type = "number", Default = 0},
		sound = {Type = "number", Default = 0}
	},
    music = {
		id = {Type = "number", Default = 0},
		volume = {Type = "number", Default = 1},
		paused = {Type = "boolean", Default = false},
	},
	scriptCollectible = {
        name = {Type = "string", Default = "rename this or you\'re a poo poo head"},
        active = {Type = "boolean", Default = false}
    },
    pause = {},
    oscillator = {
        amplitude = {Type = "number", Default = 1},
        frequency = {Type = "number", Default = 1},
        axis = {Type = "string", Default = "y"}
    },
    lockRotationAxis = {
        x = {Type = "boolean", Default = false},
        y = {Type = "boolean", Default = false},
        z = {Type = "boolean", Default = false}
	},
	cracked = {
		time = {Type = "number", Default = 2},
		instant = {Type = "boolean", Default = false},
		respawn = {Type = "boolean", Default = true},
		animation = {Type = "number", Default = 0},
	},
    dash = {
        animation = {Type = "number", Default = 0},
        factor = {Type = "number", Default = 3},
        time = {Type = "number", Default = 3}
    },
    respawner = {
        active = {Type = "boolean", Default = false},
        time = {Type = "number", Default = 0}
    },
    scriptCollectibleDisplay = {
	},
	key = {
		scriptCollectible = {Type = "Object", Default = nil},
	},
	gyroBlock = {
		hits = {Type = "number", Default = 2},
		ring1 = {Type = "Object", Default = nil},
		ring2 = {Type = "Object", Default = nil},
	},

	crackedWall = {
		animation =  {Type = "number", Default = 0},
		time = {Type = "number", Default = 0}
    },
    hydrophobic = {
    },
    bonk = {
        power = {Type = "number", Default = 20},
		animation = {Type = "number", Default = 0},
		sound = {Type = "number", Default = 0}
    },
    gravity = {
        ignore = {Type = "boolean", Default = true}
	},
	parent = {
		parent = {Type = "Object", Default = nil}
	},
	healthUI = {
		player = {Type = "Object", Default = nil},
		image = {Type ="number", Default = 2324645164},
		rectOffset3 = {Type = "Vector2", Default = Vector2.new()},
		rectOffset2 = {Type = "Vector2", Default = Vector2.new()},
		rectOffset1 = {Type = "Vector2", Default = Vector2.new()},
		rectOffset0 = {Type = "Vector2", Default = Vector2.new()}
	},
	speaker = {
		id = {Type = "number", Default = 0},
		playing = {Type = "boolean", Default = false},
		volume = {Type = "number", Default = 1},
	},
	swingingUprightPlatform = {
		speed = {Type = "number", Default = 2},
		range = {Type = "number", Default = 45},
	},
	musicTracker = {
		entity = {Type = "Object", Default = nil},
	},
}