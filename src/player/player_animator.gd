extends Node

class_name PlayerAnimator


signal animation_finished

@export var animation_player: AnimationPlayer
@export var anim_library_name := ""

var look_direction := Vector2.RIGHT : set = set_look_direction


func _ready() -> void:
	animation_player.animation_finished.connect(func(_anim_name): animation_finished.emit())


# NOTE: Might be better to create custom method for all animations
## anim_name must be valid animation
func play_8_way_anim(anim_name: String, direction := look_direction) -> void:
	look_direction = direction
	
	var dir_angle := int(rad_to_deg(direction.angle() + PI)) % 360
	dir_angle += 23
	dir_angle /= 45
	
	match dir_angle:
		0:
			anim_name += '_W'
		1:
			anim_name += '_W'
		2:
			anim_name += '_N'
		3:
			anim_name += '_E'
		4:
			anim_name += '_E'
		5:
			anim_name += '_E'
		6:
			anim_name += '_S'
		_:
			anim_name += '_W'
	
	animation_player.play(anim_library_name + anim_name)


func set_look_direction(value: Vector2) -> void:
	look_direction = value
