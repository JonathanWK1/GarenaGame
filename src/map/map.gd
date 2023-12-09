extends Node2D

class_name Map

@onready var arena_container : Node2D = $ArenaContainer

func reset_map():
	reset_arena()

func reset_arena():
	var list_child = arena_container.get_children()
	for i in list_child:
		i.reset_trigger()
		i.reset_enemies()

