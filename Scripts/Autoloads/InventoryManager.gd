extends Node

#ITEMS
const KEY: ItemData = preload("res://Scripts/Items/Item1.tres")

var obtained_items: Array[ItemData] = []
const MAX_SIZE = 10

var selected_item: ItemData
var selected_item_index: int = 0

signal inventory_modified

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func send_inventory_modified_signal():
	inventory_modified.emit()

func remove_item(item: ItemData):
	obtained_items.erase(item)
	call_deferred("send_inventory_modified_signal")
	
func add_item(item: ItemData):
	if obtained_items.size() < MAX_SIZE:
		obtained_items.append(item)
		call_deferred("send_inventory_modified_signal")
