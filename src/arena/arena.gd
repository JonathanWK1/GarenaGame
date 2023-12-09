extends Node2D

class_name Arena

@export var spawners: Array[EnemySpawner] = []

var triggered := false
var spawned_enemies: Array[Enemy] = []
var enemy_left := 0 :
	set(value):
		enemy_left = value
		if enemy_left <= 0:
			GlobalSignal.arena_finished.emit()


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
		

func reset_trigger():
	triggered = false


func _on_trigger_area_area_entered(area: Area2D) -> void:
	if not triggered:
		GlobalSignal.arena_entered.emit(self)
		triggered = true
		spawn_enemies(area)
