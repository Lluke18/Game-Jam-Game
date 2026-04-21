extends CanvasLayer

@export var start_scene_path : String
@export var options_menu_path : String


func _on_start_pressed() -> void:
	SceneChanger.change_scene_to_path(start_scene_path)



func _on_options_pressed() -> void:
	SceneChanger.change_scene_to_path(options_menu_path)


func _on_quit_game_pressed() -> void:
	get_tree().quit()
