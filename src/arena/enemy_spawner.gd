extends Marker2D

class_name EnemySpawner


@export var enemy_scn: PackedScene


func spawn() -> Enemy:
	print("SPAWN")
	var enemy: Enemy = enemy_scn.instantiate()
	call_deferred("add_child", enemy)
	enemy.set_deferred("global_position", global_position)
	return enemy
