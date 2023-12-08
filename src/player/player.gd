extends CharacterBody2D


@export var speed := 350.0
@export var friction := 0.8
@export var acceleration := 0.9


func get_input() -> Vector2:
	return Vector2(
		Input.get_axis('move_left', 'move_right'),
		Input.get_axis('move_up', 'move_down')
		)


func _physics_process(delta: float) -> void:
	var direction := get_input()
	
	if direction.length() > 0:
		velocity = velocity.lerp(direction.normalized() * speed, acceleration)
	else:
		velocity = velocity.lerp(Vector2.ZERO, friction)
	move_and_slide()
