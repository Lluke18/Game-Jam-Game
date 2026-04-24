extends Node

@onready var item_drop_areas: Node = $CanvasLayer/ItemDropAreas

func _ready() -> void:
	connect_areas_signals()
	InventoryManager.add_item(InventoryManager.ITEM1)
	InventoryManager.add_item(InventoryManager.ITEM2)
	InventoryManager.add_item(InventoryManager.ITEM3)

func connect_areas_signals():
	for drop_area in item_drop_areas.get_children():
		if drop_area is ItemDropArea:
			drop_area.area_complete.connect(check_puzzle_complete)

func check_puzzle_complete():
	for drop_area in item_drop_areas.get_children():
		if drop_area is ItemDropArea:
			if drop_area.complete == false:
				return
	print("Puzzle Complete!")
