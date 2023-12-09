extends Node


func freeze_frame(duration := 1.0, timeScale := 0.05) -> void:
	Engine.time_scale = timeScale
	await get_tree().create_timer(timeScale * duration).timeout
	Engine.time_scale = 1
