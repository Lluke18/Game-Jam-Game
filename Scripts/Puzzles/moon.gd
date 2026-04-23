extends Node

@onready var item_drop_area: ItemDropArea = $ItemDropArea

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	InventoryManager.add_item(InventoryManager.ITEM1)
	item_drop_area.area_complete.connect(end_puzzle)

func end_puzzle():
	print("The Moon finished!")
	PuzzleManager.complete_puzzles[PuzzleManager.puzzles.MOON] = true
	SignalBus.moon_completed.emit()
