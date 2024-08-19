extends Control

func _ready():
	$Fullscreen.button_pressed = Settings.fullscreen
	$CameraShake.button_pressed = Settings.camera_shake
	$Particles.button_pressed = Settings.particles
	$Music.value = Settings.music_vol
	$SFX.value = Settings.sfx_vol

func _on_fullscreen_toggled(on):
	Audio.play("click")
	Settings.fullscreen = on
	Settings.save()
	DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN if on else DisplayServer.WINDOW_MODE_WINDOWED)

func _on_camera_shake_toggled(on):
	Audio.play("click")
	Settings.camera_shake = on
	Settings.save()

func _on_particles_toggled(on):
	Audio.play("click")
	Settings.particles = on
	Settings.save()

func _on_music_value_changed(value):
	Settings.music_vol = value
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Music"), value)

func _on_sfx_value_changed(value):
	Settings.sfx_vol = value
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("SFX"), value)

func _on_sfx_drag_ended(_value):
	Audio.play("click")
	Settings.save()

func _on_music_drag_ended(_value):
	Audio.play("click")
	Settings.save()
