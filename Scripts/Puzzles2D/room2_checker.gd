extends Node

@onready var moon: Node2D = $"../../Moon"

func _ready() -> void:
	if PuzzleManager.complete_puzzles[PuzzleManager.puzzles.MOON] == false:
		TextManager.show_once("room_2_checker", [
		"Wait, is that the moon... inside the glass?", 
		"How is that even possible? It looks like I could just reach in.", 
		"This is getting weirder by the second."
	])
