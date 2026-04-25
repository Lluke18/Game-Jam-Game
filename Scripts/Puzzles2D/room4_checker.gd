extends Node

@onready var star: Button = $Star

func _ready() -> void:
	if PuzzleManager.calendar_solved == true:
		star.disabled = true
