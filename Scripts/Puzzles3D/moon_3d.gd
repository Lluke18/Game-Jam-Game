extends Node

@onready var moon_shape: InteractableObject = $StaticBody3D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if PuzzleManager.moon_symbol_picked_up == true:
		moon_shape.queue_free()
	else:
		moon_shape.interact = Callable(self, "_on_moon_pickup")

func _on_moon_pickup():
	InventoryManager.add_item(InventoryManager.MOONSIGN)
	TextManager.show_once("mainroom_pick_moon", [
		"Got it. I should take it back.", 
		"Let's hope the mirror still works and I am not stuck." 
	])
	PuzzleManager.moon_symbol_picked_up = true
	SaveManager.save_file_data.moon_symbol_picked_up = true
	moon_shape.queue_free()
