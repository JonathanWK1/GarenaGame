extends Control

@onready var label := $Panel/ColorRect/ColorRect/Label
@onready var button_container := $Panel/ColorRect/ColorRect/ButtonContainer

var list = []
var list_answer = [5,6,3,7]
func _ready():
	var buttons = button_container.get_children()
	var count = 1
	var temp = true
	for b in buttons:
		b.id = count
		if (count == 11 and temp):
			b.id = 0
			temp = false
		else:
			count += 1
		
		
		if (b.id <= 9):
			b.label.text = str(b.id)
		elif (b.id == 10):
			b.label.text = "B"
		elif (b.id == 11):
			b.label.text = "E"
			
			
		b.is_pressed.connect(add_to_label)
		
func submit():
	if (len(list) != 4) : return false
	for i in range(4):
		if (list[i] != list_answer[i]):
			return false
	return true
	
func add_to_label(id : int):
	print(id)
	if (id == 11):
		if submit():
			GlobalSignal.correct_password.emit()
		else:
			hide()

	
	if (id == 10):
		list.pop_back()
		var text = ""
		for i in list:
			text += str(i)
		label.text = text

	if (len(label.text) >= 4): return
	
	if (id <= 9):
		list.append(id)
		var text = ""
		for i in list:
			text += str(i)
		label.text = text

