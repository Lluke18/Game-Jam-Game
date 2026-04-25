extends CanvasLayer

@onready var options_panel = $OptionsPanel
@onready var sfx_player = $SfxPlayer

func _ready() -> void:
	hide()
	process_mode = Node.PROCESS_MODE_ALWAYS
	

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_cancel"):
		if options_panel.visible:
			options_panel.visible = false
			return
		if get_tree().paused:
			resume()
		else:
			pause()

func resume() -> void:
	get_tree().paused = false
	hide()
	var current_scene = get_tree().current_scene
	print("Scena curenta: ", get_tree().current_scene.name)
	if current_scene.name == "Mainroom":
		await get_tree().process_frame
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	

func pause() -> void:
	show()
	sfx_player.play()
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	get_tree().paused = true

func _on_resume_pressed() -> void:
	resume()

func _on_options_pressed() -> void:
	options_panel.visible = true

func _on_quit_pressed() -> void:
	get_tree().paused = false
	SaveManager.save_data()
	get_tree().change_scene_to_file("res://scenes/2d/main_menu.tscn")
	hide()
