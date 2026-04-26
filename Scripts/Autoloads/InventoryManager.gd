extends Node

#ITEMS
const MOONSIGN: ItemData = preload("res://Scripts/Items/MoonSign.tres")
const PENCIL: ItemData = preload("res://Scripts/Items/Pencil.tres")
const BLUE_POT: ItemData = preload("res://Scripts/Items/BluePot.tres")
const GREEN_POT: ItemData = preload("res://Scripts/Items/GreenPot.tres")
const YELLOW_POT: ItemData = preload("res://Scripts/Items/YellowPot.tres")
const SMALL_SACK: ItemData = preload("res://Scripts/Items/SmallSack.tres")
const MEDIUM_SACK: ItemData = preload("res://Scripts/Items/MediumSack.tres")
const BIG_SACK: ItemData = preload("res://Scripts/Items/BigSack.tres")

const MAX_SIZE = 8

var obtained_items: Array[ItemData] = []
var selected_item: ItemData
var selected_item_index: int = 0

signal inventory_modified

func send_inventory_modified_signal():
	inventory_modified.emit()

func remove_item(item: ItemData):
	obtained_items.erase(item)
	call_deferred("send_inventory_modified_signal")
	
func add_item(item: ItemData):
	if obtained_items.size() < MAX_SIZE:
		obtained_items.append(item)
		call_deferred("send_inventory_modified_signal")

func reset_data():
	obtained_items = []
	selected_item = null
	selected_item_index = 0

func load_data():
	obtained_items = SaveManager.save_file_data.obtained_items
	selected_item = SaveManager.save_file_data.selected_item
	selected_item_index = SaveManager.save_file_data.selected_item_index
