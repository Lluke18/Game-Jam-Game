extends Node

@onready var zodiac_interactable: InteractableObject = $StaticBody3D
@onready var zodiac_wheel: Node3D = $StaticBody3D/Zodiac_wheel


func _ready() -> void:
	if PuzzleManager.calendar_solved == false:
		zodiac_interactable.remove_from_group("Interactables")
		return
	if PuzzleManager.complete_puzzles[PuzzleManager.puzzles.STAR] == false:
		zodiac_interactable.interact = Callable(self, "_on_zodiac_click")
		zodiac_wheel.skip_animation = false
	else:
		zodiac_wheel.skip_animation = true
		zodiac_interactable.remove_from_group("Interactables")
		zodiac_wheel.aries_fall()

func _on_zodiac_click():
	print("you got the correct zodiac!")
	zodiac_wheel.aries_fall()
	print("The Star finished!")
	PuzzleManager.finish_puzzle(PuzzleManager.puzzles.STAR)
	SignalBus.star_completed.emit()
	zodiac_interactable.remove_from_group("Interactables")
