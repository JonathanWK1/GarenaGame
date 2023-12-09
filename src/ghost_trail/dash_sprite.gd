extends Sprite2D


func _ready():
	var tween := get_tree().create_tween()
	tween.tween_property(self, "modulate:a", 0.0, 1.0)
	#$Tween.interpolate_property(self,"modulate:a",1.0,0.0,1,1,3)
	#$Tween.start()


func _on_Tween_tween_completed(object: Object, key: NodePath) -> void:
	queue_free()
