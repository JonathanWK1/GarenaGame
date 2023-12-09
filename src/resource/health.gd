extends Resource

class_name Health


signal hp_changed()
signal dead()

@export var max_hp : int = 3
@export var hp := 1 :
	set(value):
		hp = value
		hp_changed.emit()
		
		if hp <= 0:
			dead.emit()

func _ready():
	reset_health()
	
	
func reset_health():
	hp = max_hp
