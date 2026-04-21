extends Button

@export var destination_room_path : String

func _on_pressed() -> void:
	SceneChanger.change_scene_to_path(destination_room_path)
