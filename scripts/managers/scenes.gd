extends CanvasLayer

@onready var animation = $AnimationPlayer

func load(scene):
	animation.play_backwards("slide")
	await animation.animation_finished
	var packed = load("res://scenes/%s.tscn" % scene)
	get_tree().change_scene_to_packed(packed)
	animation.play("slide")

func reload():
	animation.play_backwards("slide")
	await animation.animation_finished
	get_tree().reload_current_scene()
	animation.play("slide")
