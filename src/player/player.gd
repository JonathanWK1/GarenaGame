extends CharacterBody2D


@export var state_chart: StateChart
@export var trail_manager: TrailManager
@export var animator: PlayerAnimator
@export var health: Health

@export var weapon_pivot: Marker2D
@export var weapon_hitbox: HitBox

@export var speed := 350.0
@export var friction := 0.8
@export var acceleration := 0.9

@export var dash_speed := 1000.0

var direction := Vector2.ZERO

var weapon_rotation := 0.0


func get_move_input() -> Vector2:
	return Vector2(
		Input.get_axis('move_left', 'move_right'),
		Input.get_axis('move_up', 'move_down')
		)


#region Normal State
func _on_normal_state_physics_processing(delta: float) -> void:
	var input_direction := get_move_input()
	
	if input_direction.length() > 0:
		direction = input_direction
		if Input.is_action_just_pressed('dash'):
			state_chart.send_event('dash')
			return
		
		velocity = velocity.lerp(direction.normalized() * speed, acceleration)
		animator.play_8_way_anim('walk', direction)
	else:
		velocity = velocity.lerp(Vector2.ZERO, friction)
		animator.play_8_way_anim('idle')
	move_and_slide()
	
	if Input.is_action_just_pressed('attack'):
		weapon_rotation = global_position.angle_to_point(get_global_mouse_position())
		state_chart.send_event('attack')
#endregion


#region Attack State
func _on_attack_state_entered() -> void:
	print(Vector2.RIGHT.rotated(weapon_rotation))
	animator.play_8_way_anim('first_attack', Vector2.RIGHT.rotated(weapon_rotation))
	weapon_pivot.rotation = weapon_rotation
	weapon_hitbox.enable()


func _on_attack_state_unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed('dash'):
		direction = get_move_input()
		state_chart.send_event('dash')
		get_viewport().set_input_as_handled()


func _on_attack_state_exited() -> void:
	weapon_hitbox.disable()
#endregion


#region Dash State
func _on_dash_state_entered() -> void:
	animator.play_8_way_anim('dash', direction)
	velocity = direction.normalized() * dash_speed
	trail_manager.summon_trail(4, 0.3)


func _on_dash_state_physics_processing(delta: float) -> void:
	move_and_slide()
#endregion
