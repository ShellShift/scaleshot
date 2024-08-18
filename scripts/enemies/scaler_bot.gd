extends Enemy

@export var bullet_prefab: PackedScene
@export var fire_rate: float
var fire_timer: float
var decrease: bool

func _process(delta):
	fire_timer += delta
	if fire_timer >= fire_rate:
		var bullet = bullet_prefab.instantiate()
		bullet.scale = global_scale
		bullet.position = $FirePoint.global_position
		bullet.decrease = decrease
		bullet.fire($FirePoint.global_rotation)
		add_sibling(bullet)
		fire_timer = 0
		decrease = !decrease
	if target < position.x:
		$FirePoint.position.x = -9
		$FirePoint.rotation = PI
	else:
		$FirePoint.position.x = 9
		$FirePoint.rotation = 0
