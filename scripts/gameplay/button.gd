extends RigidBody2D

@export var target: Node2D
@export var toggle: bool
@export var inverted: bool
@export var require_scale: bool
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
	if inverted: enabled = !enabled
	is_enabled = enabled
	$Sprite.frame = 1 if is_enabled else 0
	Particles.spawn_particle("jump", self)
	Camera.shake()

func toggle_active():
	if !toggle: return set_active(true)
	is_enabled = !is_enabled
	set_active(is_enabled)

func _on_body_entered(body):
	if body is Player: return toggle_active()
	elif body is Box:
		if !require_scale: return toggle_active()
		if require_scale and body.state == 1:
			toggle_active()

func _on_body_exited(body):
	if toggle: return
	if body is Box or body is Player:
		set_active(false)
