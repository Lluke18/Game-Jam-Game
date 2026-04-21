class_name ItemSlot
extends Panel

@onready var icon: TextureRect = $Icon
@export var item: ItemData

func _ready() -> void:
	update_ui()

func update_ui() -> void:
	if not item:
		icon.texture = null
		tooltip_text = ""
		return
		
	icon.texture = item.icon
	tooltip_text = item.item_name

func _can_drop_data(at_position: Vector2, data: Variant) -> bool:
	return true

func _get_drag_data(at_position: Vector2) -> Variant:
	#check if the slot is empty
	if not item:
		print("Nu are item!")
		return
		
	var preview_image = duplicate()
	var preview = Control.new()
	preview.add_child(preview_image)
	preview_image.position -= Vector2(25,25)
	preview_image.self_modulate = Color.TRANSPARENT
	
	set_drag_preview(preview)
	return self
