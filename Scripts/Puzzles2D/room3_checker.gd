extends Node

@onready var death: Button = $Death
@onready var sfx_player: AudioStreamPlayer2D = $"../../SfxPlayer"
@onready var sfx_player_2: AudioStreamPlayer2D = $"../../SfxPlayer2"



func _ready() -> void:
	if PuzzleManager.complete_puzzles[PuzzleManager.puzzles.DEATH] == true:
		death.disabled = true

func _on_grimoire_pressed() -> void:
	if PuzzleManager.completed_puzzles == 6:
		PuzzleManager.finish_puzzle(PuzzleManager.puzzles.WORLD)
		sfx_player.play()
		TextManager.show_once("World_completed", [
			"A mirror only shatters when its work is done!"
		])
		SignalBus.world_completed.emit()
		await get_tree().create_timer(6).timeout
		SceneChanger.change_scene_to_path("res://Rooms/Room2.tscn")
		sfx_player_2.play()
	else:
		TextManager.show_once("World_empty", [
			"Not yet! I need all the other 6 cards for this spell"
		])
	
