extends CanvasLayer

@export var start_scene_path : String
@export var options_menu_path : String

@onready var continue_button: Button = $TextureRect/ButtonManager/Continue

func _ready() -> void:
	if FileAccess.file_exists("user://SaveFile.tres") == false:
		continue_button.disabled = true

func _on_start_pressed() -> void:
	DirAccess.remove_absolute("user://SaveFile.tres")
	
	SceneChanger.change_scene_to_path(start_scene_path)
	
func _on_continue_pressed() -> void:
	pass # Replace with function body.
	
func _on_options_pressed() -> void:
	SceneChanger.change_scene_to_path(options_menu_path)

func _on_quit_game_pressed() -> void:
	get_tree().quit()
