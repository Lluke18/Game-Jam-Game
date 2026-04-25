extends Node

@onready var blue_static_body_3d: InteractableObject = $BluePot/BlueStaticBody3D
@onready var green_static_body_3d: InteractableObject = $GreenPot/GreenStaticBody3D
@onready var yellow_static_body_3d: InteractableObject = $YellowPot/YellowStaticBody3D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	blue_static_body_3d.interact = Callable(self, "_on_bluepot_pickup")
	green_static_body_3d.interact = Callable(self, "_on_greenpot_pickup")
	yellow_static_body_3d.interact = Callable(self, "_on_yellowpot_pickup")

func _on_bluepot_pickup():
	InventoryManager.add_item(InventoryManager.BLUE_POT)
	PuzzleManager.blue_pot_picked_up = true
	SaveManager.save_file_data.blue_pot_picked_up = PuzzleManager.blue_pot_picked_up
	print("bluepot picked up!")
	blue_static_body_3d.queue_free()
	
func _on_greenpot_pickup():
	InventoryManager.add_item(InventoryManager.GREEN_POT)
	PuzzleManager.green_pot_picked_up = true
	SaveManager.save_file_data.green_pot_picked_up = PuzzleManager.green_pot_picked_up
	print("greenpot picked up!")
	green_static_body_3d.queue_free()
	
func _on_yellowpot_pickup():
	InventoryManager.add_item(InventoryManager.YELLOW_POT)
	PuzzleManager.yellow_pot_picked_up = true
	SaveManager.save_file_data.yellow_pot_picked_up = PuzzleManager.yellow_pot_picked_up
	print("yellowpot picked up!")
	yellow_static_body_3d.queue_free()
