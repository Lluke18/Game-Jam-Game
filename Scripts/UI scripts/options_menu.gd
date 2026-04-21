extends Control

@export var main_menu_path : String

func _on_button_3_pressed() -> void:
	SceneChanger.change_scene_to_path(main_menu_path)
