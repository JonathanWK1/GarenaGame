extends Node2D


@onready var hit_particle := $HitParticle
@onready var sprite := $Sprite
@onready var collision := $Collision/CollisionShape2D
@onready var collision_trigger := $Area2D/CollisionShape2D


func _on_area_2d_area_entered(area: Area2D) -> void:
	sprite.hide();
	collision.set_deferred('disabled', true)
	collision_trigger.set_deferred('disabled', true)
	hit_particle.emitting = true;


func _on_hit_particle_finished():
	queue_free()
