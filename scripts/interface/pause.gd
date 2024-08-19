extends UIManager

func enable(a):
	super.enable(a)

func toggle_pause():
	var tree = get_tree()
	var tween = create_tween()
	tree.paused = !tree.paused
	tween.tween_property(self, "scale", Vector2.ONE if tree.paused else Vector2.ZERO, time) \
		.set_ease(Tween.EASE_IN_OUT) \
		.set_trans(Tween.TRANS_SINE)
	tween.set_pause_mode(Tween.TWEEN_PAUSE_PROCESS)
	Audio.play("click")

func _process(_delta):
	if Input.is_action_just_pressed("pause"):
		toggle_pause()

func restart():
	toggle_pause()
	Scenes.reload()

func quit(_game = null):
	toggle_pause()
	super.quit(false)
