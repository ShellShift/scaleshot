extends Area2D

@export var door: Door
@export var max_angle: float
@export var angle_speed: float
var angle: float

func _process(delta):
	angle += delta * angle_speed
	if angle > max_angle: angle = -max_angle
	$Sprite.position.y = sin(angle)

func _on_body_entered(_body):
	door.open_door()
	queue_free()
	Audio.play("key", self)
	Particles.spawn_particle("explosion", self)
	Camera.shake()
