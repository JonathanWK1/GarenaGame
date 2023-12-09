extends CharacterBody2D

class_name Bullet


@export var hitbox: HitBox
@export var parry_raycast: RayCast2D

var speed := 1000.0


func initialize(rot: float) -> void:
	global_rotation = rot
	velocity = Vector2.RIGHT.rotated(global_rotation) * speed


func _physics_process(delta: float) -> void:
	if move_and_slide():
		queue_free()
	
	if parry_raycast.is_colliding():
		parry_raycast.enabled = false
		hitbox.collision_mask ^= 6
		velocity = -velocity
