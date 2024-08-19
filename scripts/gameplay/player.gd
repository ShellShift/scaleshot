class_name Player extends CharacterBody2D

@export var speed: float
@export var jump_velocity: float
@export var coyote_time: float
@export var jump_time: float
@export var push: float
var coyote_timer: float
var jump_timer: float
var jumping: bool

const gravity = 980
func _physics_process(delta):
	if not is_on_floor():
		velocity.y += gravity * delta
		coyote_timer += delta
	else: coyote_timer = 0
	
	if Input.is_action_just_pressed("jump") and (is_on_floor() or coyote_timer < coyote_time):
		jump(jump_velocity)
	if jumping and jump_timer < jump_time:
		velocity.y = -jump_velocity
		jump_timer += delta
	if Input.is_action_just_released("jump"):
		jumping = false
		jump_timer = 0
	
	var direction = Input.get_axis("left", "right")
	velocity.x = direction * speed
	if direction < 0:
		$Sprite.flip_h = true
		$LeftArm.position.x = 5
	if direction > 0:
		$Sprite.flip_h = false
		$LeftArm.position.x = -6
	
	if move_and_slide():
		for i in get_slide_collision_count():
			var col = get_slide_collision(i)
			var body = col.get_collider()
			if body is Box:
				body.velocity.x = col.get_normal().x * -push
	if position.y > 150: die()

func jump(force):
	jumping = true
	velocity.y = -force
	Particles.spawn_particle("jump", self)
	Camera.shake(0.05, 0.5)
	Audio.play("jump", self)

func die():
	Particles.spawn_particle("explosion", self)
	Camera.shake()
	queue_free()
	Scenes.reload()
	Audio.play("die", self)
