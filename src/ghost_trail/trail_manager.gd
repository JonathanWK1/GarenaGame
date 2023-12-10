extends Node

class_name TrailManager


@export var body: CharacterBody2D
@export var dash_sprite: PackedScene = preload("res://src/ghost_trail/dash_sprite.tscn")
@export var sprite: Sprite2D


func summon_trail(amount := 2, duration := 0.5) -> void:
	for _i in range(amount):
		var new_dash: Sprite2D = dash_sprite.instantiate()
		body.get_parent().call_deferred("add_child", new_dash)
		
		new_dash.global_position = sprite.global_position
		new_dash.texture = sprite.texture
		new_dash.hframes = sprite.hframes
		new_dash.vframes = sprite.vframes
		new_dash.frame = sprite.frame
		new_dash.flip_h = sprite.flip_h
		new_dash.flip_v = sprite.flip_v
		new_dash.scale = sprite.scale
		new_dash.global_rotation = sprite.global_rotation
		
		print(new_dash.global_position)
		print(sprite.global_position)
		
		await get_tree().create_timer(duration / amount).timeout
