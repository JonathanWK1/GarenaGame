extends Node2D


@onready var spawn_position : Marker2D = $Map/SpawnPosition
@onready var player : Player = $Player
@onready var map : Node2D = $Map
@onready var camera: GameCamera = $Camera2D
@onready var timer : Timer = $Timer

@export var UI_Dead : Control
@export var time_limit : int = 180

var lost_text = "You Died 

Press R to Restart"


var win_text = "Congratulation

You Escaped 

Press R to Restart"

var iteration = 1:
	set(value):
		iteration = value
		GlobalSignal.iteration_changed.emit(iteration)

var switch_triggered = false


func _ready():
	spawn_player()
	GlobalSignal.switch_triggered.connect(
		func () :
			switch_triggered = true
			GlobalSignal.play_audio.emit(preload('res://assets/audios/540321__colorscrimsontears__system-shutdown.wav'))
	)
	player.health.dead.connect(reset_loop)


func spawn_player():
	player.global_position = spawn_position.global_position
	player.health.hp = 3


func reset_loop():
	if (switch_triggered) :
		UI_Dead.set_text(lost_text)
		UI_Dead.show()
		return
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


func _on_reset_area_area_entered(area):
	if (!switch_triggered):
		reset_loop()
	else:
		UI_Dead.set_text(win_text)
		UI_Dead.show()
		
