extends Node

@onready var zodiac_interactable: InteractableObject = $StaticBody3D
@onready var zodiac_wheel: Node3D = $StaticBody3D/Zodiac_wheel
@onready var interactable_area_3d: InteractableArea3D = $StaticBody3D/InteractableArea3D
var dialogue_shown: bool = false
@onready var sfx_player: AudioStreamPlayer3D = $"../../SfxPlayer"
@onready var sfx_player_2: AudioStreamPlayer3D = $"../../SfxPlayer2"

func say_something():
	if not dialogue_shown:
		dialogue_shown = true
		TextManager.show_once("Zodiac_Seen", [
		"I’ve spent half my life tracing these symbols in my books. Seeing the Great Wheel like this... feels like a dream. I need to see where my alignment actually falls."
	])

func _ready() -> void:
	interactable_area_3d.body_entered.connect(_on_player_entered)
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

func _on_player_entered(body: Node3D) -> void:
	if body is CharacterBody3D:
		say_something()

func _on_zodiac_click():
	sfx_player.play()
	print("you got the correct zodiac!")
	zodiac_wheel.aries_fall()
	print("The Star finished!")
	PuzzleManager.finish_puzzle(PuzzleManager.puzzles.STAR)
	sfx_player_2.play()
	TextManager.show_once("Zodiac_completed", [
		"The Star. Number seventeen. Hope and renewal... a reminder that there’s actually a purpose to this mess."
	])
	SignalBus.star_completed.emit()
	zodiac_interactable.remove_from_group("Interactables")
