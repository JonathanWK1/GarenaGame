extends TextureRect


@export var health: Health
@export var bound_value: int = 0


func _ready() -> void:
	health.hp_changed.connect(
		func() -> void:
			visible = health.hp >= bound_value
	)
