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
		elasticityWeight = {Type = "number", Default = 1}
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
	},
	
	character = {
		controllable = {Type = "boolean", Default = false},
		camera = {Type = "Object", Defualt = nil},
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
	},
	
	charData = {
		coins = {Type = "number", Default = 0}
	},
	
	stats = {
		coins = {Type = "number", Default = 0}
	},
	
	jump = {
		power = {Type = "number", Default = 50}
	},

	dive = {
		power = {Type = "number", Default = 50}
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
		speed = {Type = "number", Default = 1}
	},
	
	animator = {
	},
	
	frame = {
		frame = {Type = "Instance", Default = nil}
	},
	
	uiTransform = {
		position = {Type = "UDim2", Default = UDim2.new()},
		size = {Type = "UDim2", Default = UDim2.new()},
		zIndex = {Type = "number", Default = 0},
	},
	
	label = {
		text = {Type = "string", Default = "label"}
	},
	
	button = {
		-- havent made events yet /shrug
	},
	
	sound = {
		id = {Type = "number", Default = 0}
	}

}