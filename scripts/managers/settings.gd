extends Node

var sfx_vol: float
var music_vol: float
var fullscreen: bool = true
var camera_shake: bool = true
var particles: bool = true

func _ready():
	if !FileAccess.file_exists("user://settings.save"): return
	var file = FileAccess.open("user://settings.save", FileAccess.READ)
	var data = JSON.parse_string(file.get_as_text())
	file.close()
	sfx_vol = data.sfx_vol
	music_vol = data.music_vol
	fullscreen = data.fullscreen
	camera_shake = data.camera_shake
	particles = data.particles
	if fullscreen:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("SFX"), data.sfx_vol)
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Music"), data.music_vol)

func save():
	var file = FileAccess.open("user://settings.save", FileAccess.WRITE)
	file.store_string(JSON.stringify({
		"sfx_vol": sfx_vol,
		"music_vol": music_vol,
		"fullscreen": fullscreen,
		"camera_shake": camera_shake,
		"particles": particles
	}))
	file.close()
