extends Control

func _ready():
	$Particles.button_pressed = Settings.particles
	$Lighting.button_pressed = Settings.lighting
	$Music.value = Settings.music_vol
	$SFX.value = Settings.sfx_vol

func _on_particles_toggled(on):
	Settings.particles = on
	Settings.save()

func _on_lighting_toggled(on):
	Settings.lighting = on
	Settings.save()

func _on_music_value_changed(value):
	Settings.music_vol = value
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Music"), value)

func _on_sfx_value_changed(value):
	Settings.sfx_vol = value
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("SFX"), value)

func _on_sfx_drag_ended(_value):
	# TODO Play sound effect
	Settings.save()

func _on_music_drag_ended(_value):
	Settings.save()
