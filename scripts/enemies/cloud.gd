extends Enemy

@export var jump_velocity: float
@export var player: Player

func _on_head_area_entered(body):
	if body is Player:
		body.jump(jump_velocity)
		Particles.spawn_particle("jump", self)
		stepped_on_head = true

func _process(_delta):
	if stepped_on_head:
		return
	if is_instance_valid(player_collided):
		player_collided.die()
