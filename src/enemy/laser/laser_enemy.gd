extends Enemy


@export var sprite_shader: ShaderMaterial

@export var state_chart: StateChart
@export var animation_player: AnimationPlayer
@export var laser: Laser
@export var laser_audio: AudioStreamPlayer
@export var charge_audio: AudioStreamPlayer

@export var idle_speed := 50.0

var laser_target := Vector2.ZERO


func _ready() -> void:
	health.hp = 4
	health.dead.connect(queue_free)


func laser_targeting() -> void:
	laser_target = target.global_position


func shoot() -> void:
	laser.target_position = laser.to_local(laser_target).normalized() * 2000.0
	laser_audio.play()
	laser.is_casting = true
	await get_tree().create_timer(0.3).timeout
	laser.is_casting = false


#region Idle State
func _on_idle_state_entered() -> void:
	animation_player.play('idle')
	velocity = Vector2.RIGHT.rotated(randf_range(-PI, PI)) * idle_speed
	await get_tree().create_timer(randf_range(1, 2)).timeout
	state_chart.send_event('idle_finished')


func _on_idle_state_physics_processing(delta: float) -> void:
	move_and_slide()
#endregion


func _on_shooting_state_entered() -> void:
	charge_audio.play()
	animation_player.play('shooting')


func _on_hurt_box_attack_detected(attack_position: Vector2) -> void:
	sprite_shader.set_shader_parameter('flash_modifier', 1.0)
	GlobalEffects.freeze_frame(0.2)
	health.hp -= 1
	await get_tree().create_timer(0.1).timeout
	sprite_shader.set_shader_parameter('flash_modifier', 0.0)
