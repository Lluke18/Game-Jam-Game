extends Node


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_pressed() -> void:
	SaveManager.save_data()
	SceneChanger.change_scene_to_path("res://scenes/2d/main_menu.tscn")
