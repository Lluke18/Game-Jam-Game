class_name Room

extends Node


@export var room_3d_path : String

@export var mirror : InteractArea
@export var left_room_path : String
@export var right_room_path : String 

func _ready() -> void:
	#pt tranzitia de la 3d, ca mouse-ul sa se vada din nou in 2d
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	if mirror:
		mirror.interact = Callable(self, "_on_mirror_change")

func _on_mirror_change():
	print("SWITCHING!")
	
	InteractionManager.unregister_area(mirror) # so it doesnt cause errors in 3d
	SceneChanger.change_scene_to_path(room_3d_path)

func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("3D_left"):
		SceneChanger.change_scene_to_path(left_room_path)
	if Input.is_action_just_pressed("3D_right"):
		SceneChanger.change_scene_to_path(right_room_path)
