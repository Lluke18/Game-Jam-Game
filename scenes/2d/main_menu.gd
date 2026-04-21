extends CanvasLayer


func _on_start_pressed() -> void:
	get_tree().change_scene_to_file("res://Rooms/Room2.tscn")
	#helo


func _on_options_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/3d/mainroom.tscn")


func _on_quit_game_pressed() -> void:
	get_tree().quit()
