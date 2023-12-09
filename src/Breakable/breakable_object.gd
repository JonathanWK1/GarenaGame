extends Node2D


@onready var hit_particle := $HitParticle
@onready var sprite := $Sprite
@onready var collision := $Collision/CollisionShape2D
@onready var collision_trigger := $Area2D/CollisionShape2D

func _on_area_2d_area_shape_entered(area_rid, area, area_shape_index, local_shape_index):
	sprite.hide();
	collision.disabled = true;
	collision_trigger.disabled = true;
	hit_particle.emitting = true;


func _on_hit_particle_finished():
	queue_free()
