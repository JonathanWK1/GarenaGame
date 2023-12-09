extends StaticBody2D


@export var is_active : bool = false

@onready var collision := $CollisionShape2D
@onready var sprite := $Gate

func _ready():
	set_active(is_active)

func set_active(value):
	is_active = value
	collision.set_deferred('disabled', not is_active)
	if (is_active):
		sprite.show()
	else:
		sprite.hide()
