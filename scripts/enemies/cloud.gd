extends Enemy

@export var jump_velocity: float
var angle: float
var bounce_pad: bool

func _on_head_area_entered(body):
	if body is Player:
		if !bounce_pad:
			speed = 0
			bounce_pad = true
			$Sprite.frame = 1
			$Sprite.scale = Vector2.ONE * 1.25
			$Sprite.position.y = -4
			$Sprite/Platform.hide()
			animation.play("RESET")
			animation = null
			Camera.shake()
			Particles.spawn_particle("explosion", self)
			Audio.play("die", self)
			return
		body.jump(jump_velocity)
		$AnimationPlayer.play("jump")
		Particles.spawn_particle("jump", self)

func _on_scaled(decrease):
	if bounce_pad: return
	super._on_scaled(decrease)

func _on_body_area_entered(body):
	if bounce_pad:
		return
	super._on_body_area_entered(body)
