extends Node

@onready var the_magician: Button = $"The Magician"

func _ready() -> void:
	if PuzzleManager.complete_puzzles[PuzzleManager.puzzles.MAGICIAN] == true:
		the_magician.disabled = true
