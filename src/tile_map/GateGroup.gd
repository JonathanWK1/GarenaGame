extends Node2D

class_name GateGroup

var is_locked := false

func set_gate_active(value):
	if (is_locked): return
	var list_gate = get_children()
	for i in list_gate:
		i.set_active(value)


