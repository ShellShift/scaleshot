extends Node

var sfx_vol: float
var music_vol: float
var particles: bool = true
var lighting: bool = true

func _ready():
	if !FileAccess.file_exists("user://settings.save"): return
	var file = FileAccess.open("user://settings.save", FileAccess.READ)
	var data = JSON.parse_string(file.get_as_text())
	file.close()
	sfx_vol = data.sfx_vol
	music_vol = data.music_vol
	particles = data.particles
	lighting = data.lighting
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("SFX"), data.sfx_vol)
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Music"), data.music_vol)

func save():
	var file = FileAccess.open("user://settings.save", FileAccess.WRITE)
	file.store_string(JSON.stringify({
		"sfx_vol": sfx_vol,
		"music_vol": music_vol,
		"particles": particles,
		"lighting": lighting
	}))
	file.close()
