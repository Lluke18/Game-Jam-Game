extends Button

@export var destination_room_path : String

func _on_pressed() -> void:
	SceneChanger.change_scene_to_path(destination_room_path)

func _on_mouse_entered() -> void:
	print("A intrat mouse-ul!")
	scale = Vector2(1.2,1.2)

func _on_mouse_exited() -> void:
	scale = Vector2(1,1)
