extends Area2D

class_name HitBox


signal hurt_box_detected(hurt_box)


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


func _on_area_entered(hurtbox: HurtBox) -> void:
	hurt_box_detected.emit(hurtbox)
	hurtbox.got_hit(global_position)
