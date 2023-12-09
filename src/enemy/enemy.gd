extends CharacterBody2D

class_name Enemy


var health := Health.new()
var target : Node2D = null

@export var label: Label


func _ready():
	label.text = str(health.hp)
	health.hp_changed.connect(
		func() -> void:
			label.text = str(health.hp)
	)


func set_target(area : Node2D):
	target = area


