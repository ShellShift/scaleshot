class_name Enemy extends CharacterBody2D

@export var speed: float
@export var speed_modifiers: Vector2
@export var leftTarget: float
@export var rightTarget: float
@export var startGoingRight: bool
@onready var scalable = $Scalable
var start_speed: float
var target: float

func _ready():
	start_speed = speed
	rightTarget += position.x
	leftTarget += position.x
	target = rightTarget if startGoingRight else leftTarget

const gravity = 980
func _physics_process(delta):
	if abs(position.x - target) < 1:
		target = leftTarget if target == rightTarget else rightTarget
	if position.y > 150:
		die()
	if not is_on_floor():
		velocity.y += gravity * delta
	
	var direction = -1 if target < position.x else 1
	velocity.x = direction * speed
	$Sprite.flip_h = direction < 0
	move_and_slide()

func die():
	Particles.spawn_particle("explosion", self)
	Camera.shake()
	queue_free()

func _on_head_area_entered(body):
	if body is Player:
		die()

func _on_body_area_entered(body):
	if body is Player:
		body.die()

func _on_scaled(decrease):
	var tween = create_tween()
	var target_speed: float
	if decrease: target_speed = start_speed * speed_modifiers.x
	else: target_speed = start_speed / speed_modifiers.y
	tween.tween_property(self, "speed", target_speed, scalable.time)
