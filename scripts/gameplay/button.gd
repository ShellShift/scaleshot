extends Area2D

@export var target: Node2D
@export var toggle: bool
@export var inverted: bool
@export var require_scale: bool
var standing: int
var is_enabled: bool
var collider: CollisionShape2D

func _ready():
	if is_instance_valid(target) and target.has_node("CollisionShape"):
		collider = target.get_node("CollisionShape")
	if !inverted: set_active(false)
	$Sprite.frame = 0

func set_active(enabled):
	if inverted: enabled = !enabled
	if is_instance_valid(target): target.visible = enabled
	if is_instance_valid(collider): collider.set_deferred("disabled", !enabled)
	if inverted: enabled = !enabled
	is_enabled = enabled
	$Sprite.frame = 1 if is_enabled else 0
	Particles.spawn_particle("jump", self)
	Camera.shake()
	Audio.play("button", self)

func toggle_active():
	if !toggle:
		standing += 1
		return set_active(true)
	is_enabled = !is_enabled
	set_active(is_enabled)

func on_box_scale(decrease):
	if !require_scale: return
	if !decrease:
		if toggle: return
		return set_active(true)
	if toggle: return toggle_active()
	set_active(false)

func _on_body_entered(body):
	if body is Player and !require_scale: return toggle_active()
	elif body is Box:
		if !require_scale:
			return toggle_active()
		if body.state == 1:
			toggle_active()
		body.get_node("Scalable").scaled.connect(on_box_scale)

func _on_body_exited(body):
	if body is Box:
		body.get_node("Scalable").scaled.disconnect(on_box_scale)
	if toggle: return
	if body is Box or body is Player:
		standing -= 1
		if standing <= 0:
			standing = 0
			set_active(false)
