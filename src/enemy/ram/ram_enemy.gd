extends Enemy


@export var sprite_shader: ShaderMaterial

@export var state_chart: StateChart
@export var animator: Animator
@export var hitbox: HitBox
@export var dust_particle: GPUParticles2D
@export var charge_particle: GPUParticles2D
@export var charge_sprite: Sprite2D

@export var idle_speed := 50.0
@export var ram_speed := 700.0

var ram_time := 0.0


func _ready() -> void:
	super._ready()
	health.hp = 6
	health.dead.connect(queue_free)


#region Idle State
func _on_idle_state_entered() -> void:
	var direction := Vector2.RIGHT.rotated(randf_range(-PI, PI))
	animator.play_8_way_anim('walk', direction)
	velocity = direction * idle_speed
	await get_tree().create_timer(randf_range(1, 5)).timeout
	state_chart.send_event('idle_finished')


func _on_idle_state_physics_processing(delta: float) -> void:
	move_and_slide()
#endregion


#region Charging State
func _on_charging_state_entered() -> void:
	animator.play_8_way_anim('charging', target.global_position - global_position)
#endregion


#region Ram State
func _on_ram_state_entered() -> void:
	var v2 := target.global_position - global_position
	var angle := v2.angle()
	animator.play_8_way_anim('ram', v2)
	velocity = Vector2.RIGHT.rotated(angle) * ram_speed
	hitbox.enable()
	charge_sprite.show()
	ram_time = 2.0


func _on_ram_state_physics_processing(delta: float) -> void:
	ram_time -= delta
	
	if ram_time < 1.0:
		velocity = velocity.normalized() * lerpf(0.1, ram_speed, ram_time)
	
	if move_and_slide():
		state_chart.send_event('ram_collided')


func _on_ram_state_exited() -> void:
	hitbox.disable()
	dust_particle.emitting = false
	charge_sprite.hide()
#endregion


func _on_hurt_box_attack_detected(attack_position: Vector2) -> void:
	sprite_shader.set_shader_parameter('flash_modifier', 1.0)
	GlobalEffects.freeze_frame(0.2)
	health.hp -= 1
	await get_tree().create_timer(0.1).timeout
	sprite_shader.set_shader_parameter('flash_modifier', 0.0)


func _on_hit_box_hurt_box_detected(hurt_box: Variant) -> void:
	state_chart.send_event('ram_collided')
