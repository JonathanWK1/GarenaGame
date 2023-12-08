extends Node

class_name TrailManager


@export var body: CharacterBody2D
@export var dash_sprite: PackedScene = preload("res://src/ghost_trail/dash_sprite.tscn")
@export var real_sprite: Sprite2D


func summon_trail(amount := 2, duration := 0.5) -> void:
	for _i in range(amount):
		var new_dash: Sprite2D = dash_sprite.instantiate()
		body.get_parent().call_deferred("add_child", new_dash)
		
		new_dash.global_position = real_sprite.global_position
		new_dash.texture = real_sprite.texture
		new_dash.hframes = real_sprite.hframes
		new_dash.frame = real_sprite.frame
		new_dash.vframes = real_sprite.vframes
		new_dash.flip_h = real_sprite.flip_h
		new_dash.flip_v = real_sprite.flip_v
		new_dash.scale.x = real_sprite.scale.x
		new_dash.scale.y = real_sprite.scale.y
		new_dash.global_rotation = real_sprite.global_rotation
		
		await get_tree().create_timer(duration / amount).timeout
