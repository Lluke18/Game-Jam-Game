class_name Room

extends Node


@export var room_3d_path : String

@export var left_room_path : String
@export var right_room_path : String 

var can_switch: bool = false

func _ready() -> void:
	#pt tranzitia de la 3d, ca mouse-ul sa se vada din nou in 2d
	
	can_switch = true
	
	#COMENTAT DOAR PENTRU TESTING
	#if PuzzleManager.complete_puzzles[PuzzleManager.puzzles.MAGICIAN] == true:
		#can_switch = true
	
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	TextManager.show_once("room_2", [
		"Ugh, my head... what the hell happened?",
		"I was just doing a reading and then...everything went sideways", 
	    "And why are my photos all messed up?"
	])

func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("3D_left") and can_switch:
		if left_room_path:

			SceneChanger.change_scene_to_path(left_room_path)
	if Input.is_action_just_pressed("3D_right") and can_switch:
		if right_room_path:
			SceneChanger.change_scene_to_path(right_room_path)
