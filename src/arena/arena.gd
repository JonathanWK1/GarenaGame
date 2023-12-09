extends Node2D


signal arena_finished

@export var spawners: Array[EnemySpawner] = []

var triggered := false
var spawned_enemies: Array[Enemy] = []
var enemy_left := 0 :
	set(value):
		enemy_left = value
		if enemy_left <= 0:
			arena_finished.emit()


func spawn_enemies(area: Area2D) -> void:
	for spawner in spawners:
		var enemy := spawner.spawn()
		spawned_enemies.append(enemy)
		enemy.set_target(area)
		enemy_left += 1
		
		enemy.health.dead.connect(
			func():
				enemy_left -= 1
		)


func _on_trigger_area_area_entered(area: Area2D) -> void:
	if not triggered:
		triggered = true
		spawn_enemies(area)
