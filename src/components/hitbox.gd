extends Area2D

class_name HitBox


signal hurt_box_detected(hurt_box)

var group_name := ""


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


func _on_area_entered(area: HurtBox) -> void:
	if area.group_name != group_name:
		hurt_box_detected.emit(area)
