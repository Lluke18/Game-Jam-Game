extends CanvasLayer

@onready var options_panel = $OptionsPanel
@onready var continue_button: Button = $TextureRect/ButtonManager/Continue
@export var start_scene_path : String
@export var options_menu_path : String 

@onready var cutscene_node = $Cutscene 
@onready var anim_player: AnimationPlayer = $Cutscene/CanvasLayer/AnimationPlayer
@onready var skip_button = $Cutscene/CanvasLayer/Control/Button

func _ready() -> void:
	#Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	cutscene_node.hide()
	skip_button.hide()
	if FileAccess.file_exists("user://SaveFile.tres") == false:
		continue_button.disabled = true
		continue_button.modulate.a = 0.5
	options_panel.visible = false

func _on_start_pressed() -> void:
	DirAccess.remove_absolute("user://SaveFile.tres")
	InventoryManager.reset_data()
	PuzzleManager.reset_data()
	$TextureRect.hide()       
	cutscene_node.show()
	skip_button.show()
	skip_button.pressed.connect(_on_skip_pressed)
	anim_player.play("intro")
	await anim_player.animation_finished
	SceneChanger.change_scene_to_path(start_scene_path)

func _on_options_pressed() -> void:
	options_panel.visible = true
	SceneChanger.change_scene_to_path(options_menu_path)

func _on_continue_pressed() -> void:
	InventoryManager.load_data()
	PuzzleManager.load_data()
	get_tree().change_scene_to_file("res://Rooms/Room2.tscn")

func _on_quit_game_pressed() -> void:
	get_tree().quit()


func _on_skip_pressed() -> void:
	anim_player.stop()
	SceneChanger.change_scene_to_path(start_scene_path)
