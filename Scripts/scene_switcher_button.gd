extends Button

@export var destination_room_path : String

func _ready() -> void:
	mouse_entered.connect(_on_mouse_entered)
	mouse_exited.connect(_on_mouse_exited)

func _on_pressed() -> void:
	SceneChanger.change_scene_to_path(destination_room_path)

func _on_mouse_entered() -> void:
	scale = Vector2(1.2,1.2)
	pivot_offset = size / 2

func _on_mouse_exited() -> void:
	scale = Vector2(1,1)
	pivot_offset = size / 2
