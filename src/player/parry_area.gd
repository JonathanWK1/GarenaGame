extends Area2D

class_name ParryArea


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
