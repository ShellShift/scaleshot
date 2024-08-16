class_name Camera extends Camera2D

@export var target: Node2D
var shake_time: float
var shake_strength: float
static var camera: Camera2D

func _ready():
	camera = self

func _process(delta):
	if shake_time > 0:
		shake_time -= delta
		offset = Vector2(randf_range(-shake_strength, shake_strength), randf_range(-shake_strength, shake_strength))
	else: offset = Vector2.ZERO
	position = target.position

static func shake(shake_time = 0.1, shake_strength = 1):
	camera.shake_time = shake_time
	camera.shake_strength = shake_strength
