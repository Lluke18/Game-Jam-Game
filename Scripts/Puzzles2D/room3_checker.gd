extends Node

@onready var death: Button = $Death


func _ready() -> void:
	if PuzzleManager.complete_puzzles[PuzzleManager.puzzles.DEATH] == true:
		death.disabled = true

func _on_grimoire_pressed() -> void:
	if PuzzleManager.completed_puzzles == 6:
		PuzzleManager.finish_puzzle(PuzzleManager.puzzles.WORLD)
		TextManager.show_once("World_completed", [
			"A mirror only shatters when its work is done!"
		])
		SignalBus.world_completed.emit()
		await get_tree().create_timer(3).timeout
		SceneChanger.change_scene_to_path("res://Rooms/Room2.tscn")
	else:
		TextManager.show_once("World_empty", [
			"Not yet! I need all the other 6 cards for this spell"
		])
	
