extends Control

@export var time: float

func show_heart():
	var tween = create_tween()
	tween.tween_property($Heart, "scale", Vector2.ONE, time) \
		.set_ease(Tween.EASE_IN_OUT) \
		.set_trans(Tween.TRANS_SINE)

func hide_heart():
	var tween = create_tween()
	tween.tween_property($Heart, "scale", Vector2.ZERO, time) \
		.set_ease(Tween.EASE_IN_OUT) \
		.set_trans(Tween.TRANS_SINE)
