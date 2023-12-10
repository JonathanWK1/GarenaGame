extends Node2D

class_name Arena

@export var spawners: Array[EnemySpawner] = []
@export var gate_group_list: Array[GateGroup] = []

@export var id : = 0
var triggered := false
var spawned_enemies: Array[Enemy] = []
var enemy_left := 0 :
	set(value):
		enemy_left = value
		if enemy_left <= 0:
			set_gate(false)
			GlobalSignal.arena_finished.emit()
			GlobalSignal._arena_finished.emit(self)


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
	set_gate(false)
	print("reset trigger")


func reset_enemies():
	enemy_left = 0
	for i in spawned_enemies:
		if (is_instance_valid(i)):
			i.queue_free()
	spawned_enemies.clear()


func _on_trigger_area_area_entered(area: Area2D) -> void:
	if not triggered:
		GlobalSignal.arena_entered.emit(self)
		triggered = true
		set_gate(true)
		spawn_enemies(area)


func set_gate(value):
	for gate_group in gate_group_list:
		gate_group.set_gate_active(value)
