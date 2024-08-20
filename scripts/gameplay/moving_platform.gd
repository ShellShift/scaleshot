extends CharacterBody2D

@export var speed: float
@export var left_target: float
@export var right_target: float
@export var move_with: CharacterBody2D
var target: float

func _ready():
	right_target += position.x
	left_target += position.x
	target = right_target
	move_with.friction = 0

func _physics_process(delta):
	if position.distance_to(Vector2(target, position.y)) < 1:
		target = left_target if target == right_target else right_target
	var direction = -1 if target < position.x else 1
	move_with.velocity.x = direction * speed
	velocity.x = direction * speed
	move_and_slide()
