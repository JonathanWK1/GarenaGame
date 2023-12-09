extends Node2D


@onready var spawn_position : Marker2D = $Map/SpawnPosition
@onready var player : Player = $Player
@onready var map : Node2D = $Map
@onready var camera: GameCamera = $Camera2D


func _ready():
	spawn_player()
	player.health.dead.connect(reset_loop)


func spawn_player():
	player.global_position = spawn_position.global_position
	player.health.hp = 3


func reset_loop():
	map.reset_map()
	spawn_player()
	camera.set_target_to_player()
