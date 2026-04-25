extends Node

@onready var death: Button = $Death
@onready var star: Button = $Star

func _ready() -> void:
	if PuzzleManager.complete_puzzles[PuzzleManager.puzzles.DEATH] == true:
		death.disabled = true
	if PuzzleManager.calendar_solved == true:
		star.disabled = true
