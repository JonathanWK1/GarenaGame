extends RamEnemy


@onready var special_collision: CollisionShape2D = $SpecialArea/CollisionShape2D


func _on_ram_state_entered() -> void:
	super._on_ram_state_entered()
	special_collision.set_deferred('disabled', false)


func _on_ram_state_exited() -> void:
	super._on_ram_state_exited()
	special_collision.set_deferred('disabled', true)


func _on_special_area_area_entered(area: Area2D) -> void:
	collided_audio.play()
	state_chart.send_event('ram_collided')
