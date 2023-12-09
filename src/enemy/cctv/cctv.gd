extends Node2D


@export var player: Player
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
	
	if player_inside and player.velocity.length() > 0.05:
		player.health.hp = 0


func _on_area_2d_area_entered(area: Area2D) -> void:
	player_inside = true


func _on_area_2d_area_exited(area: Area2D) -> void:
	player_inside = false
