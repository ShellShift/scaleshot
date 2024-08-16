extends Node2D

func _process(_delta):
	look_at(get_global_mouse_position())
	var should_flip = global_rotation > PI/2 or global_rotation < -PI/2
	$Gun.flip_v = should_flip
	$Square.position.y = 3 * (1 if should_flip else -1)
