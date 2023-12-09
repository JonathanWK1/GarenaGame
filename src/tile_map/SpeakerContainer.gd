extends Node2D

@onready var first_npc = $NPC1
# Called when the node enters the scene tree for the first time.
func _ready():
	GlobalSignal.iteration_changed.connect(set_text_npc1)
	pass # Replace with function body.

func set_text_npc1(value):
	var text = "Training iteration " + str(value) + ",your objective is to finish the training module within the time limit, good luck."
	first_npc.set_text(text)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
