extends Node2D

class_name GateGroup

var is_locked := false

@export var id : int = 0

func _ready():
	GlobalSignal.correct_password.connect(open_password_gate)

func set_gate_active(value):
	if (is_locked): return
	var list_gate = get_children()
	for i in list_gate:
		i.set_active(value)

func open_password_gate():
	if (id == 1):
		GlobalSignal.play_audio.emit(preload("res://assets/audios/339632__nichols8917__door-closing.wav"))
		var list_gate = get_children()
		for i in list_gate:
			i.set_active(false)
		

