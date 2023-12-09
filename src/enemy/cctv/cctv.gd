extends Node2D


@export var player: Player
@export var laser: BigLaser
@export var rotation_speed := 30.0
@export var min_rotation := -45.0
@export var max_rotation := 45.0

var player_inside := false
var clockwise_rotation := true

var shot := false


func _physics_process(delta: float) -> void:
	if clockwise_rotation:
		global_rotation_degrees += rotation_speed * delta
	else:
		global_rotation_degrees -= rotation_speed * delta
	
	if global_rotation_degrees < min_rotation:
		clockwise_rotation = true
	elif global_rotation_degrees > max_rotation:
		clockwise_rotation = false
	
	if not shot and player_inside and player.velocity.length() > 0.01:
		shot = true
		laser.target_position = laser.to_local(player.global_position).normalized() * 2000.0
		laser.is_casting = true
		await get_tree().create_timer(0.3).timeout
		laser.is_casting = false
		shot = false


func _on_area_2d_area_entered(area: Area2D) -> void:
	player_inside = true


func _on_area_2d_area_exited(area: Area2D) -> void:
	player_inside = false
