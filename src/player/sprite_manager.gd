extends Node2D

class_name SpriteManager


signal sprite_changed(texture: Texture, frame_size: Vector2)

@export var current_sprite_index: int = 0 : set = set_current_sprite_index

var current_sprite: Sprite2D


func _ready() -> void:
	for child in get_children():
		(child as Sprite2D).hide()
	
	current_sprite = (get_child(current_sprite_index) as Sprite2D)
	current_sprite.show()


func get_sprite_texture() -> Texture:
	return current_sprite.texture


func get_frame_size() -> Vector2:
	return current_sprite.texture.get_size() / Vector2(current_sprite.hframes, current_sprite.vframes)


func get_frame_coords() -> Vector2:
	return current_sprite.frame_coords


func get_zero_frag_coords() -> Vector2:
	return current_sprite.get_global_transform_with_canvas().origin - get_frame_size() / 2 + current_sprite.offset


func set_current_sprite_index(value: int) -> void:
	current_sprite.hide()
	
	current_sprite_index = value
	current_sprite = (get_child(current_sprite_index) as Sprite2D)
	current_sprite.show()
	
	sprite_changed.emit(get_sprite_texture(), get_frame_size())
