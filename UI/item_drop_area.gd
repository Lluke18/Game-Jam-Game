extends Control

const WORLD_ITEM_2D = preload("res://WorldItems2D/PuzzleObject.tscn")

func _can_drop_data(at_position: Vector2, data: Variant) -> bool:
	return true
	
func _drop_data(at_position: Vector2, data: Variant) -> void:
	var node = WORLD_ITEM_2D.instantiate()
	
	node.texture_normal = data.item.world_2d_image
	
	get_tree().current_scene.get_node("CanvasLayer").add_child(node)
	node.global_position = get_global_mouse_position()
	data.item = null
