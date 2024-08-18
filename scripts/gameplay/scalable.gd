extends Node2D

signal scaled(decrease)

@export var multiplier: float
@export var time: float
var start_scale: Vector2
var scale_state: int

func _ready():
	start_scale = $"..".scale

func run(decrease):
	if scale_state == 1 and !decrease: return
	if scale_state == -1 and decrease: return
	scale_state = -1 if decrease else 1	
	var new_scale = Vector2(multiplier, multiplier)
	if decrease: new_scale = start_scale / new_scale
	else: new_scale = start_scale * new_scale
	var tween = create_tween()
	tween.tween_property($"..", "scale", new_scale, time) \
		.set_ease(Tween.EASE_IN_OUT) \
		.set_trans(Tween.TRANS_SINE)
	scaled.emit(decrease)
