extends Node

@onready var moon_shape: InteractableObject = $MoonShape

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if PuzzleManager.moon_symbol_picked_up == true:
		moon_shape.queue_free()
	else:
		moon_shape.interact = Callable(self, "_on_moon_pickup")

func _on_moon_pickup():
	InventoryManager.add_item(InventoryManager.ITEM3)
	PuzzleManager.moon_symbol_picked_up = true
	moon_shape.queue_free()
