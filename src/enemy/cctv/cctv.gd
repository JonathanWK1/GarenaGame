extends Node2D


@export var player: Player
@export var laser: BigLaser
@export var rotation_speed := 30.0
@export var min_rotation := -45.0
@export var max_rotation := 45.0

var player_inside := false
var clockwise_rotation := true


func _ready():
	GlobalSignal.broadcast_player.connect(set_player)


func set_player(player:Player):
	self.player = player


func _physics_process(delta: float) -> void:
	if clockwise_rotation:
		rotation_degrees += rotation_speed * delta
	else:
		rotation_degrees -= rotation_speed * delta
	
	if rotation_degrees < min_rotation:
		clockwise_rotation = true
	elif rotation_degrees > max_rotation:
		clockwise_rotation = false
	
	if player_inside and player.velocity.length() > 0.01:
		player.health.hp = 0
		laser.target_position = laser.to_local(player.global_position).normalized() * 2000.0
		laser.is_casting = true
		await get_tree().create_timer(0.3).timeout
		laser.is_casting = false


func _on_area_2d_body_entered(body: Node2D) -> void:
	player_inside = true


func _on_area_2d_body_exited(body: Node2D) -> void:
	player_inside = false
