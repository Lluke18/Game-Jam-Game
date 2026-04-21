class_name Room

extends Node

@export var room_left_path : String
@export var room_right_path : String
@export var room_3d_path : String

@onready var room_ui : RoomUI = get_node("CanvasLayer/RoomUI")
@export var mirror : InteractArea


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if room_ui.has_left_arrow:
		room_ui.left_arrow_pressed.connect(_on_left_arrow_pressed)
	if room_ui.has_right_arrow:
		room_ui.right_arrow_pressed.connect(_on_right_arrow_pressed)
	if mirror:
		mirror.interact = Callable(self, "_on_mirror_change")
		
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func _on_left_arrow_pressed():
	SceneChanger.change_scene_to_path(room_left_path)
	
func _on_right_arrow_pressed():
	SceneChanger.change_scene_to_path(room_right_path)

func _on_mirror_change():
	SceneChanger.change_scene_to_path(room_3d_path)
