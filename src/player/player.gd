extends CharacterBody2D

class_name Player

@export var health: Health
@export var sprite_shader: ShaderMaterial

@export var state_chart: StateChart
@export var trail_manager: TrailManager
@export var animator: Animator
@export var invulnerable_anim_player: AnimationPlayer
@export var hurtbox: HurtBox
@export var parry_area: ParryArea
@export var slash_sprites: Array[Sprite2D] = []
@export var weapon_pivot: Marker2D
@export var weapon_hitbox: HitBox

@export var speed := 350.0
@export var friction := 0.8
@export var acceleration := 0.9

@export var dash_speed := 1000.0

var direction := Vector2.ZERO
var attacked_direction := Vector2.ZERO

var weapon_rotation := 0.0
var attack_combo := 0
var attack_queue := false

var can_dash := true


func get_move_input() -> Vector2:
	return Vector2(
		Input.get_axis('move_left', 'move_right'),
		Input.get_axis('move_up', 'move_down')
		)


#region Normal State
func _on_normal_state_entered() -> void:
	if attack_queue:
		attack_queue = false
		state_chart.send_event('attack')
	else:
		attack_combo = 0


func _on_normal_state_physics_processing(delta: float) -> void:
	var input_direction := get_move_input()
	
	if input_direction.length() > 0:
		direction = input_direction
		if Input.is_action_just_pressed('dash') and can_dash:
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
	
	if Input.is_action_just_pressed('parry'):
		weapon_rotation = global_position.angle_to_point(get_global_mouse_position())
		state_chart.send_event('parry')
#endregion


#region Attack State
func _on_attack_state_entered() -> void:
	slash_sprites[attack_combo].show()
	animator.play_8_way_anim('first_attack' if attack_combo == 0 else 'second_attack', Vector2.RIGHT.rotated(weapon_rotation))
	weapon_pivot.rotation = weapon_rotation
	weapon_hitbox.enable()
	attack_combo ^= 1
	velocity = Vector2.RIGHT.rotated(weapon_rotation) * speed


func _on_attack_state_unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed('dash') and can_dash:
		direction = get_move_input()
		state_chart.send_event('dash')
		get_viewport().set_input_as_handled()
	
	if event.is_action_pressed('attack'):
		attack_queue = true
		weapon_rotation = global_position.angle_to_point(get_global_mouse_position())
		get_viewport().set_input_as_handled()
	
	if event.is_action_pressed('parry'):
		attack_queue = false
		weapon_rotation = global_position.angle_to_point(get_global_mouse_position())
		state_chart.send_event('parry')
		get_viewport().set_input_as_handled()


func _on_attack_state_physics_processing(delta: float) -> void:
	velocity = velocity.lerp(Vector2.ZERO, 0.2)
	move_and_slide()


func _on_attack_state_exited() -> void:
	slash_sprites[0].hide()
	slash_sprites[1].hide()
	weapon_hitbox.disable()
#endregion


#region Dash State
func _on_dash_state_entered() -> void:
	can_dash = false
	animator.play_8_way_anim('dash', direction)
	velocity = direction.normalized() * dash_speed
	trail_manager.summon_trail(6, 0.3)


func _on_dash_state_physics_processing(delta: float) -> void:
	move_and_slide()
	hurtbox.disable()


func _on_dash_state_exited() -> void:
	hurtbox.enable()
	await get_tree().create_timer(1.0).timeout
	can_dash = true
#endregion


#region Invulnerable State
func _on_invulnerable_state_entered() -> void:
	invulnerable_anim_player.play('invulnerable')


# BAD: conflicting with dash lol
func _on_invulnerable_state_physics_processing(delta: float) -> void:
	hurtbox.disable()


func _on_invulnerable_state_exited() -> void:
	hurtbox.enable()
#endregion


#region Parry State
func _on_parry_state_entered() -> void:
	animator.play_8_way_anim('parry', Vector2.RIGHT.rotated(weapon_rotation))
	weapon_pivot.rotation = weapon_rotation
	parry_area.enable()
	await get_tree().create_timer(0.3).timeout
	parry_area.disable()
#endregion


#region Staggered State
func _on_staggered_state_entered() -> void:
	animator.play_8_way_anim('dash', attacked_direction)
	velocity = -attacked_direction.normalized() * speed


func _on_staggered_state_physics_processing(delta: float) -> void:
	move_and_slide()


func _on_staggered_state_exited() -> void:
	pass # Replace with function body.
#endregion


func _on_hurt_box_attack_detected(attack_position: Vector2) -> void:
	attacked_direction = attack_position - global_position
	state_chart.send_event('hurt')
	sprite_shader.set_shader_parameter('flash_modifier', 1.0)
	GlobalEffects.freeze_frame(0.5)
	health.hp -= 1
	await get_tree().create_timer(0.05).timeout
	sprite_shader.set_shader_parameter('flash_modifier', 0.0)

