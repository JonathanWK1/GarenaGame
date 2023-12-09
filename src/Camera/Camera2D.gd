extends Camera2D


@export var player : Node2D

var target : Node2D
# Called whe$"../Player"n the node enters the scene tree for the first time.
func _ready():
	GlobalSignal.arena_finished.connect(set_target_to_player);
	GlobalSignal.arena_entered.connect(set_target);
	set_target_to_player()

func set_target(arena : Node2D):
	target = arena

func set_target_to_player():
	target = player
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	global_position = target.global_position;
	pass