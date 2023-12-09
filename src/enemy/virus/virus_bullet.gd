extends CharacterBody2D

class_name Bullet


var speed := 1000.0


func initialize(rot: float) -> void:
	global_rotation = rot
	velocity = Vector2.RIGHT.rotated(global_rotation) * speed


func _physics_process(delta: float) -> void:
	if move_and_slide():
		queue_free()
