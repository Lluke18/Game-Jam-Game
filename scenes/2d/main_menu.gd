extends CanvasLayer

@onready var options_panel = $OptionsPanel
@onready var continue_button: Button = $TextureRect/ButtonManager/Continue
@export var start_scene_path : String
@export var options_menu_path : String

func _ready() -> void:
	if FileAccess.file_exists("user://SaveFile.tres") == false:
		continue_button.disabled = true
	options_panel.visible = false

func _on_start_pressed() -> void:
	DirAccess.remove_absolute("user://SaveFile.tres")
	InventoryManager.reset_data()
	SceneChanger.change_scene_to_path(start_scene_path)

func _on_options_pressed() -> void:
	options_panel.visible = true
	SceneChanger.change_scene_to_path(options_menu_path)

func _on_continue_pressed() -> void:
	InventoryManager.load_data()
	get_tree().change_scene_to_file("res://Rooms/Room2.tscn")

func _on_quit_game_pressed() -> void:
	get_tree().quit()
