extends RayCast2D

class_name BigLaser


@onready var line: Line2D = $Line2D

var is_casting := false : set = set_is_casting

var hit := false # BUG: hit player twice, has to check if already hit


func _ready() -> void:
	line.points[1] = Vector2.ZERO


func _physics_process(delta: float) -> void:
	var cast_point := target_position
	
	force_raycast_update()
	
	if is_colliding():
		cast_point = to_local(get_collision_point())
		
		var collider := get_collider()
		
		if not hit and collider is HurtBox:
			collider.got_hit(get_collision_point())
			hit = true
	
	line.points[1] = cast_point


func set_is_casting(value: bool) -> void:
	is_casting = value
	
	if is_casting:
		hit = false
		appear()
	else:
		disappear()
	
	set_physics_process(is_casting)


func appear() -> void:
	var tween = get_tree().create_tween()
	tween.tween_property(line, 'width', 15.0, 0.2)


func disappear() -> void:
	var tween = get_tree().create_tween()
	tween.tween_property(line, 'width', 0.0, 0.1)
