extends Node

class_name TrailManager


@export var body: CharacterBody2D
@export var dash_sprite: PackedScene = preload("res://src/ghost_trail/dash_sprite.tscn")
@export var sprite: Sprite2D


func summon_trail(amount := 2, duration := 0.5) -> void:
	for _i in range(amount):
		var new_dash: Sprite2D = dash_sprite.instantiate()
		body.get_parent().call_deferred("add_child", new_dash)
		
		new_dash.set_deferred('global_position', sprite.global_position)
		new_dash.set_deferred('texture', sprite.texture)
		new_dash.set_deferred('hframes', sprite.hframes)
		new_dash.set_deferred('vframes', sprite.vframes)
		new_dash.set_deferred('frame', sprite.frame)
		new_dash.set_deferred('flip_h', sprite.flip_h)
		new_dash.set_deferred('flip_v', sprite.flip_v)
		new_dash.set_deferred('scale', sprite.scale)
		new_dash.set_deferred('global_rotation', sprite.global_rotation)
		
		await get_tree().create_timer(duration / amount).timeout
