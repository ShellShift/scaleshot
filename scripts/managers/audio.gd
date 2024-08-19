extends Node

@export var time: float
var music: String
var music_player: AudioStreamPlayer2D

func _ready():
	process_mode = Node.PROCESS_MODE_ALWAYS

func play(audio, parent = null):
	var stream = load("res://audio/%s.wav" % audio)
	var player = AudioStreamPlayer2D.new()
	if parent: player.position = parent.global_position
	player.pitch_scale = randf_range(1, 2)
	player.stream = stream
	player.bus = "SFX"
	player.autoplay = true
	if parent: get_tree().current_scene.call_deferred("add_child", player)
	else: call_deferred("add_child", player)
	player.finished.connect(func(): player.queue_free())

func play_music(audio):
	var tween = create_tween()
	var player: AudioStreamPlayer2D
	if music_player:
		if music == audio:
			tween.tween_property(music_player, "volume_db", -80, time)
		player = music_player
	else: player = AudioStreamPlayer2D.new()
	var stream = load("res://audio/%s.wav" % audio)
	player.stream = stream
	player.bus = "Music"
	player.volume_db = -80
	player.autoplay = true
	tween.tween_property(player, "volume_db", 0, time)
	if player != music_player: call_deferred("add_child", player)
	music_player = player
	music = audio
