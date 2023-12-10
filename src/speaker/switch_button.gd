extends TextureButton

@export var id : int = 0
@onready var label := $Label
signal is_pressed(id : int)


func _on_button_down():
	is_pressed.emit(id)
