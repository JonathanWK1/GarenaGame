extends Control

@onready var label := $ColorRect/Label

func _input(event):
	if (event.is_action_pressed("restart")):
		get_tree().reload_current_scene()

func set_text(value):
	label.text = value
