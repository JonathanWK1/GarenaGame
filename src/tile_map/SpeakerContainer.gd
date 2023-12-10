extends Node2D

@onready var first_npc = $NPC1


func _ready():
	GlobalSignal.iteration_changed.connect(set_text_npc1)


func set_text_npc1(value):
	var text = "Training iteration " + str(value) + "\nGood luck!"
	first_npc.set_text(text)
