extends RigidBody2D

@export var speed: float
@export var decrease: bool

func fire(angle):
	var direction = Vector2(speed, 0).rotated(angle)
	apply_impulse(direction)
	rotation = angle
	$Sprite.modulate = Color.CORAL if decrease else Color.CADET_BLUE

func _on_body_entered(body):
	if body.has_node("Scalable"):
		body.get_node("Scalable").scale(decrease)
	queue_free()
