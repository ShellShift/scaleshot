extends Area2D

@export var target: Node2D
@export var inverted: bool
@export var toggle: bool
var is_enabled: bool
var collider: CollisionShape2D

func _ready():
	if target.has_node("CollisionShape"):
		collider = target.get_node("CollisionShape")
	set_active(!inverted)
	$Sprite.frame = 0

func set_active(enabled):
	if inverted: enabled = !enabled
	target.visible = enabled
	collider.set_deferred("disabled", !enabled)
	is_enabled = enabled
	if !inverted:
		$Sprite.frame = 1 if is_enabled else 0
	else:
		$Sprite.frame = 0 if is_enabled else 1
	Particles.spawn_particle("jump", self)
	Camera.shake()

func _on_body_entered(body):
	if body is Box or body is Player: set_active(true)

func _on_body_exited(body):
	if body is Box or body is Player: set_active(false)
