extends Panel

@onready var grid_container: GridContainer = $MarginContainer/GridContainer
@onready var selection_border: Panel = $MarginContainer/SelectionBorder

var slots: Array[ItemSlot]

func detect_scrolling():
	if Input.is_action_just_released("scroll_up"):
		if InventoryManager.selected_item_index > 0:
			slots[InventoryManager.selected_item_index].is_selected = false
			InventoryManager.selected_item_index -= 1
			update_selection()
	elif Input.is_action_just_released("scroll_down"):
		if InventoryManager.selected_item_index < (InventoryManager.MAX_SIZE - 1):
			slots[InventoryManager.selected_item_index].is_selected = false
			InventoryManager.selected_item_index += 1
			update_selection()

func init_slots_array():
	for child in grid_container.get_children():
		if child is ItemSlot:
			slots.append(child)

func _ready() -> void:
	init_slots_array()
	update_bar()
	InventoryManager.inventory_modified.connect(update_bar)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	detect_scrolling()
	if Input.get_current_cursor_shape() == DisplayServer.CURSOR_FORBIDDEN:
		DisplayServer.cursor_set_shape(DisplayServer.CURSOR_ARROW)

var initial_drag_data
func _notification(what: int) -> void:
	if what == Node.NOTIFICATION_DRAG_BEGIN:
		initial_drag_data = get_viewport().gui_get_drag_data()
	if what == Node.NOTIFICATION_DRAG_END:
		if not is_drag_successful():
			if initial_drag_data:
				initial_drag_data.icon.show()
				initial_drag_data = null

func update_selection():
	selection_border.global_position = slots[InventoryManager.selected_item_index].global_position
	InventoryManager.selected_item = slots[InventoryManager.selected_item_index].item
	slots[InventoryManager.selected_item_index].is_selected = true

func update_bar():
	var slot_index: int = 0
	for item in InventoryManager.obtained_items:
		slots[slot_index].item = item
		slots[slot_index].update_ui()
		slot_index += 1
	
	#if an item was removed, the last slot need to be emptied
	if slot_index < InventoryManager.MAX_SIZE:
		slots[slot_index].item = null
		slots[slot_index].update_ui()
	
	call_deferred("update_selection")
