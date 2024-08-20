extends Control

@onready var template = $GridContainer/Template
@onready var grid = $GridContainer
@export var level_count: int

func _ready():
	Audio.play_music("menu")
	for i in range(level_count):
		var level = i + 1
		var button = template.duplicate()
		button.text = str(level)
		button.pressed.connect(func():
			Audio.play("click")
			Scenes.load("level_%d" % level)
		)
		grid.add_child(button)
	template.queue_free()
