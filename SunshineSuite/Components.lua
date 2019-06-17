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
		trigger = {Type = "boolean", Default = false}
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
		shirtGraphic = {Type = "string", Default = ""},
		shirtGraphicColor = {Type = "Color3", Default = Color3.fromRGB(255, 255, 255)},
		shirt = {Type = "string", Default = ""},
		shirtColor = {Type = "Color3", Default = Color3.fromRGB(255, 255, 255)},
		pants = {Type = "string", Default = ""},
		pantsColor = {Type = "Color3", Default = Color3.fromRGB(255, 255, 255)},
		headColor = {Type = "Color3", Default = Color3.fromRGB(163, 162, 165)},
		leftArmColor = {Type = "Color3", Default = Color3.fromRGB(163, 162, 165)},
		leftLegColor = {Type = "Color3", Default = Color3.fromRGB(163, 162, 165)},
		rightArmColor = {Type = "Color3", Default = Color3.fromRGB(163, 162, 165)},
		rightLegColor = {Type = "Color3", Default = Color3.fromRGB(163, 162, 165)},
		torsoColor = {Type = "Color3", Default = Color3.fromRGB(163, 162, 165)},
		walkSpeed = {Type = "number", Default = 16},
		walkSpeedFactor = {Type = "number", Default = 1},
		moveAnimation = {Type = "number", Default = 0},
		idleAnimation = {Type = "number", Default = 0},
		fallAnimation = {Type = "number", Default = 0},
	},
	
	charData = {
		coins = {Type = "number", Default = 0}
	},
	
	stats = {
		coins = {Type = "number", Default = 0}
	},
	
	jump = {
        power = {Type = "number", Default = 50},
        animation = {Type = "number", Default = 0}
	},

	dive = {
		power = {Type = "number", Default = 50},
		bouncePower = {Type = "number", Default = 50},
        animation = {Type = "number", Default = 0},
        endAnimation = {Type = "number", Default = 0}
	},
	
	camera = {
		controllable = {Type = "boolean", Default = false},
		subject = {Type = "Object", Default = nil},
		fieldOfView = {Type = "number", Default = 70}
	},
	
	spawner = {
		object = {Type = "Object", Default = nil}
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
        font = {Type = "number", Default = 0}
	},
	
	button = {
		activated = {Type = "boolean", Default = false},
        size = {Type = "UDim2", Default = UDim2.new(0, 100, 0, 100)}
	},
	
	sound = {
		id = {Type = "number", Default = 0},
		looped = {Type = "boolean", Default = false},
        playing = {Type = "boolean", Default = false},
        volume = {Type = "number", Default = 0.5}
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
		sunRays = {Type = "boolean", Default = false}
    },
    
    crouch = {
        walkSpeedFactor = {Type = "number", Default = 0.5},
        animation = {Type = "number", Default = 0},
        moveAnimation = {Type = "number", Default = 0}
    },
    
    groundPound = {
        walkSpeedFactor = {Type = "number", Default = 0.1},
        speed = {Type = "number", Default = 50},
        delay = {Type = "number", Default = 0.5},
        startAnimation = {Type = "number", Default = 0},
        animation = {Type = "number", Default = 0},
        endAnimation = {Type = "number", Default = 0}
    },
	
	groundPoundJump = {
		power = {Type = "number", Default = 50},
        animation = {Type = "number", Default = 0}
	},
	
	backFlip = {
		power = {Type = "number", Default = 50},
		backPower = {Type = "number", Default = 50},
        animation = {Type = "number", Default = 0}
	},
	
	longJump = {
		power = {Type = "number", Default = 50},
		bouncePower = {Type = "number", Default = 50},
        animation = {Type = "number", Default = 0}
	},
    
    save = {
	},
	
	moving = {
		extend = {Type = "CFrame", Default = CFrame.new(0,0,0)},
		speed = {Type = "number", Default = 1}
    },
    
    head = {
        cFrame = {Type = "CFrame", Default = CFrame.new()},
        character = {Type = "Object", Default = nil},
        time = {Type = "number", Default = 2},
        holdTime = {Type = "number", Default = 5},
        bounceTime = {Type = "number", Default = 0.5},
    },

    bouncer = {
        power = {Type = "number", Default = 50},
        direct = {Type = "boolean", fakse}
    },

    teleporter = {
        scene = {Type = "Instance", Default = nil}
    },

    throw = {
        power = {Type = "number", Default = 50},
        distance = {Type = "number", Default = 20},
        animation = {Type = "number", Default = 0},
        head = {Type = "Object", Default = nil}
    },

    health = {
        health = {Type = "number", Default = 3}
    },

    bounce = {
        power = {Type = "number", Default = 50},
        animation = {Type = "number", Default = 0},
        bounceCount = {Type = "number", Default = 0}
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
	},

	coinCounter = {
	},
	
	charObject = {
		object = {Type = "Object", Default = nil}
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
    },
    
    hazard = {
        damage = {Type = "number", Default = 1}
    },

    player = {
        camera = {Type = "Object", Default = nil}
    }

}