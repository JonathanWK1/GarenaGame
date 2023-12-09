extends Enemy


@export var bullet_scn: PackedScene

@export var state_chart: StateChart
@export var animation_player: AnimationPlayer

@export var idle_speed := 50.0


func _ready() -> void:
	health.hp = 2
	health.dead.connect(queue_free)


func shoot() -> void:
	var bullet: Bullet = bullet_scn.instantiate()
	get_parent().call_deferred("add_child", bullet)
	bullet.set_deferred('global_position', global_position)
	bullet.initialize(global_position.angle_to_point(target.global_position))


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
	animation_player.play('shooting')


func _on_hurt_box_attack_detected(attack_position: Vector2) -> void:
	GlobalEffects.freeze_frame(0.2)
	health.hp -= 1
