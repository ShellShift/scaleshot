extends Node

func spawn_particle(particle_name, parent, color = null):
	var particle = load("res://prefabs/particles/%s.tscn" % particle_name).instantiate()
	particle.position = parent.global_position
	particle.rotation = parent.global_rotation
	particle.modulate = color if color else parent.modulate
	get_tree().current_scene.call_deferred("add_child", particle)
	particle.emitting = true
	await particle.finished
	particle.queue_free()
