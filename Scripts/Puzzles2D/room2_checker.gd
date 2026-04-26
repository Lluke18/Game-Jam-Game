extends Node

@onready var moon: Node2D = $"../../Moon"
@onready var mirror: Button = $Mirror
@onready var mirror_texture_rect: TextureRect = $Mirror/TextureRect

@export var broken_mirror_texture: Texture2D



func _ready() -> void:
	
	#DECOMENTAT DOAR PENTRU TESTARE
	#end_game()
	
	if PuzzleManager.complete_puzzles[PuzzleManager.puzzles.WORLD] == true:
		end_game()
	
	if PuzzleManager.complete_puzzles[PuzzleManager.puzzles.MOON] == false:
		TextManager.show_once("room_2_checker", [
		"Wait, is that the moon... inside the glass?", 
		"How is that even possible? It looks like I could just reach in."
	])

func break_mirror():
	mirror_texture_rect.texture = broken_mirror_texture

func end_game():
	mirror.disabled = true
	
	await get_tree().create_timer(2).timeout
	
	break_mirror()
	
	await get_tree().create_timer(2).timeout
	
	SceneChanger.change_scene_to_path("res://scenes/2d/main_menu.tscn")
