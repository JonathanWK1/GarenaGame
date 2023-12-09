extends Enemy


@export var state_chart: StateChart
@export var animator: Animator

@export var idle_speed := 50.0
@export var ram_speed := 700.0


func _ready() -> void:
	health.hp = 5
	health.dead.connect(queue_free)


#region Idle State
func _on_idle_state_entered() -> void:
	velocity = Vector2.RIGHT.rotated(randf_range(-PI, PI)) * idle_speed
	await get_tree().create_timer(randf_range(3, 5)).timeout
	state_chart.send_event('idle_finished')


func _on_idle_state_physics_processing(delta: float) -> void:
	move_and_slide()
#endregion


func _on_charging_state_entered() -> void:
	print("CHARGING")


#region Ram State
func _on_ram_state_entered() -> void:
	velocity = Vector2.RIGHT.rotated(randf_range(-PI, PI)) * ram_speed


func _on_ram_state_physics_processing(delta: float) -> void:
	if move_and_slide():
		state_chart.send_event('ram_collided')


func _on_ram_state_exited() -> void:
	pass # Replace with function body.
#endregion


func _on_hurt_box_attack_detected(attack_position: Vector2) -> void:
	health.hp -= 1


func _on_hit_box_hurt_box_detected(hurt_box: Variant) -> void:
	state_chart.send_event('ram_collided')
