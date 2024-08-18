extends Area2D

@export var open: bool
@export var next_level: int

func _ready():
	if open:
		open_door(true)

func open_door(no_effects = false):
	open = true
	$Sprite.frame += 1
	if no_effects: return
	Particles.spawn_particle("jump", self)
	Camera.shake()

func _on_body_entered(body):
	Scenes.load("level_%d" % next_level)
	Particles.spawn_particle("explosion", body)
	Particles.spawn_particle("explosion", self)
	Camera.shake()
	body.queue_free()
	queue_free()
