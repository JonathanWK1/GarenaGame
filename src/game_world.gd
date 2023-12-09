extends Node2D


@onready var spawn_position : Marker2D = $Map/SpawnPosition
@onready var player : Player = $Player
@onready var map : Node2D = $Map
@onready var camera: GameCamera = $Camera2D
@onready var timer : Timer = $Timer


@export var time_limit : int = 180

var iteration = 1:
	set(value):
		iteration = value
		GlobalSignal.iteration_changed.emit(iteration)


func _ready():
	spawn_player()
	player.health.dead.connect(reset_loop)


func spawn_player():
	player.global_position = spawn_position.global_position
	player.health.hp = 3


func reset_loop():
	iteration+=1
	reset_timer()
	map.reset_map()
	spawn_player()
	player.reset_player()
	camera.set_target_to_player()

func reset_timer():
	timer.start(time_limit)

func _on_timer_timeout():
	reset_loop()
