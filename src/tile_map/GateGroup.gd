extends Node2D

class_name GateGroup

func set_gate_active(value):
	var list_gate = get_children()
	for i in list_gate:
		i.set_active(value)
