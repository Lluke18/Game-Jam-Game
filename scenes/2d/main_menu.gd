extends CanvasLayer

@onready var options_panel = $OptionsPanel
@onready var continue_button: Button = $TextureRect/ButtonManager/Continue
@onready var cinematic_player: CinematicPlayer = $CinematicPlayer

@export var start_scene_path : String
@export var options_menu_path : String 

func _ready() -> void:
	AudioManager.music_player.play()
	#Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	cinematic_player.hide()
	if FileAccess.file_exists("user://SaveFile.tres") == false:
		continue_button.disabled = true
		continue_button.modulate.a = 0.5
	options_panel.visible = false

func _on_start_pressed() -> void:
	DirAccess.remove_absolute("user://SaveFile.tres")
	InventoryManager.reset_data()
	PuzzleManager.reset_data()
	   
	cinematic_player.show()
	cinematic_player.play_intro()
	
	await cinematic_player.cinematic_finished
	
	SceneChanger.change_scene_to_path(start_scene_path)

func _on_options_pressed() -> void:
	options_panel.visible = true

func _on_continue_pressed() -> void:
	InventoryManager.load_data()
	PuzzleManager.load_data()
	get_tree().change_scene_to_file("res://Rooms/Room2.tscn")

func _on_quit_game_pressed() -> void:
	get_tree().quit()
