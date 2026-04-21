class_name Room

extends Node

@export var room_3d_path : String

@export var mirror : InteractArea

func _ready() -> void:
	InventoryManager.add_item(InventoryManager.KEY)
	
	#pt tranzitia de la 3d, ca mouse-ul sa se vada din nou in 2d
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)

	if mirror:
		mirror.interact = Callable(self, "_on_mirror_change")

func _on_mirror_change():
	print("SWITCHING!")
	InteractionManager.unregister_area(mirror) # so it doesnt cause errors in 3d
	SceneChanger.change_scene_to_path(room_3d_path)
