extends Node2D


@export var to_show: Control


func _on_trigger_area_area_entered(area: Area2D) -> void:
	to_show.show()


func _on_trigger_area_area_exited(area: Area2D) -> void:
	to_show.hide()
