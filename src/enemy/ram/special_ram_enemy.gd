extends RamEnemy


func _on_special_area_area_entered(area: Area2D) -> void:
	state_chart.send_event('ram_collided')
