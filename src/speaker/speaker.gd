extends Node2D

class_name Speaker

@export var to_show: Control
@export var text: String
@export var sprite_texture : Texture = null

@onready var label = $ColorRect/Label
@onready var sprite = $Sprite

func _ready():
	label.text = text;
	if (sprite_texture != null):
		sprite.texture = sprite_texture

func set_text(value : String):
	label.text = value;

func _on_trigger_area_area_entered(area: Area2D) -> void:
	to_show.show()


func _on_trigger_area_area_exited(area: Area2D) -> void:
	to_show.hide()
