extends Control

@export var active: Control
@export var time: float

func enable(control_name):
	var control = get_node(control_name)
	control.show()
	control.modulate = Color.TRANSPARENT
	var tween = create_tween()
	tween.tween_property(active, "modulate", Color.TRANSPARENT, time) \
		.set_ease(Tween.EASE_IN_OUT) \
		.set_trans(Tween.TRANS_SINE)
	tween.tween_property(control, "modulate", Color.WHITE, time) \
		.set_ease(Tween.EASE_IN_OUT) \
		.set_trans(Tween.TRANS_SINE)
	await tween.finished
	active.hide()
	active = control

func quit(game):
	if game: get_tree().quit()
	Scenes.load("menus")
