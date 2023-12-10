extends StaticBody2D

@onready var color_rect := $ColorRect
@onready var label := $ColorRect/Label

var switched = false
var player_entered = false
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _input(event):
	if (event.is_action_pressed("switch") && player_entered):
		switched = true
		color_rect.hide()
		GlobalSignal.switch_triggered.emit()



func _on_area_2d_area_entered(area):
	if (!switched):
		color_rect.show()
		player_entered = true


func _on_area_2d_area_exited(area):
	color_rect.hide()
	player_entered = false

