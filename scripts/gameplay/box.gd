class_name Box extends CharacterBody2D

@export var friction: float
var state: int

const gravity = 980
func _physics_process(delta):
	if friction == 0: return move_and_slide()
	if not is_on_floor():
		velocity.y += gravity * delta
	velocity.x = move_toward(velocity.x, 0, friction * delta)
	move_and_slide()

func _on_scaled(decrease):
	state = -1 if decrease else 1
