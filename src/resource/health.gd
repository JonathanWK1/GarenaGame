extends Resource

class_name Health


signal hp_changed()
signal dead()

@export var hp := 1 :
	set(value):
		hp = value
		hp_changed.emit()
		
		if hp <= 0:
			dead.emit()
