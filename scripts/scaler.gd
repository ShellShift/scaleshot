extends Node2D

@export var bullet_prefab: PackedScene
@export var fire_rate: float
var fire_timer: float

func _process(delta):
	fire_timer -= delta
	var alt = Input.is_action_pressed("shoot_alt")
	if Input.is_action_pressed("shoot") or alt:
		if fire_timer <= 0:
			fire_timer = fire_rate
			shoot(alt)
			animate_fire_point_color(alt)
	look_at(get_global_mouse_position())
	var should_flip = global_rotation > PI/2 or global_rotation < -PI/2
	$Gun.flip_v = should_flip
	$FirePoint.position.y = 3 * (1 if should_flip else -1)

func shoot(alt):
	var bullet = bullet_prefab.instantiate()
	bullet.decrease = alt
	bullet.position = $FirePoint.global_position
	bullet.fire($FirePoint.global_rotation)
	get_tree().current_scene.add_child(bullet)
	Particles.spawn_particle("shoot", bullet)
	Camera.shake()

func animate_fire_point_color(alt):
	var color = Color.CORAL if alt else Color.CADET_BLUE
	var tween = create_tween()
	$FirePoint.modulate = Color.WHITE
	tween.tween_property($FirePoint, "modulate", color, fire_rate)
