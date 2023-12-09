extends Area2D

class_name HurtBox


signal attack_detected(attack_position: Vector2)


func enable() -> void:
	for child in get_children():
		if not child is CollisionShape2D:
			continue
		(child as CollisionShape2D).set_deferred("disabled", false)


func disable() -> void:
	for child in get_children():
		if not child is CollisionShape2D:
			continue
		(child as CollisionShape2D).set_deferred("disabled", true)


func got_hit(attack_position: Vector2) -> void:
	attack_detected.emit(attack_position)
