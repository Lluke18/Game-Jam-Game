class_name ItemDropArea

extends Control

@export var required_item: ItemData
var complete: bool = false
signal area_complete

#func _can_drop_data(at_position: Vector2, data: Variant) -> bool:
#	return true
	
func _ready() -> void:
	mouse_filter = Control.MOUSE_FILTER_STOP
	
#func _drop_data(at_position: Vector2, data: Variant) -> void:
#	if data.item.item_name != required_item.item_name:
#		print("Wrong item!")
#		return

func _gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		if InventoryManager.selected_item == null:
			return
		if InventoryManager.selected_item.item_name != required_item.item_name:
			print("Wrong item!")
			return
		InventoryManager.remove_item(InventoryManager.selected_item)
		complete = true
		area_complete.emit()
	
	# We no longer drop items in ItemDropArea
	#var node = WORLD_ITEM_2D.instantiate()
	
	#node.texture_normal = data.item.world_2d_image
	
	#get_tree().current_scene.get_node("CanvasLayer").add_child(node)
	
	
	#InventoryManager.remove_item(data.item)
	#complete = true
	#area_complete.emit()
	
	#node.global_position = get_node("TargetPosition").global_position
	
	
	#data.item = null
