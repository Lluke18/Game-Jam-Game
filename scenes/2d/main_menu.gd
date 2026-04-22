extends CanvasLayer

@onready var options_panel = $OptionsPanel
@onready var master_slider = $OptionsPanel/PanelContainer/MarginContainer/VBoxContainer/MasterSlider
@onready var music_slider  = $OptionsPanel/PanelContainer/MarginContainer/VBoxContainer/MusicSlider
@onready var sfx_slider    = $OptionsPanel/PanelContainer/MarginContainer/VBoxContainer/SfxSlider

@onready var continue_button: Button = $TextureRect/ButtonManager/Continue

func _ready() -> void:
	if FileAccess.file_exists("user://SaveFile.tres") == false:
		continue_button.disabled = true
	
	options_panel.visible = false
	master_slider.value = AudioManager.get_master_volume()
	music_slider.value  = AudioManager.get_music_volume()
	sfx_slider.value    = AudioManager.get_sfx_volume()

func _on_start_pressed() -> void:
	DirAccess.remove_absolute("user://SaveFile.tres")
	InventoryManager.reset_data()
	get_tree().change_scene_to_file("res://Rooms/Room2.tscn")

func _on_options_pressed() -> void:
	options_panel.visible = true
	
func _on_continue_pressed() -> void:
	InventoryManager.load_data()
	get_tree().change_scene_to_file("res://Rooms/Room2.tscn")
	
func _on_close_pressed() -> void:
	options_panel.visible = false

func _on_quit_game_pressed() -> void:
	get_tree().quit()

func _on_resolutions_item_selected(index: int) -> void:
	var resolutions = [
		Vector2i(1280, 720),
		Vector2i(1920, 1080),
		Vector2i(2560, 1440)
	]
	DisplayServer.window_set_size(resolutions[index])
	var screen_size = DisplayServer.screen_get_size()
	var window_size = resolutions[index]
	DisplayServer.window_set_position(screen_size / 2 - window_size / 2)
	print("Window size set to: ", DisplayServer.window_get_size())
	
func _on_master_slider_value_changed(value: float) -> void:
	AudioManager.set_master_volume(value)

func _on_music_slider_value_changed(value: float) -> void:
	AudioManager.set_music_volume(value)

func _on_sfx_slider_value_changed(value: float) -> void:
	AudioManager.set_sfx_volume(value)
