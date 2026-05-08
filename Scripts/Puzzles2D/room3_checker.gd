extends Control

@onready var death: Button = $Death
@onready var grimoire: Button = $Grimoire
@onready var pisi: Button = $"../Pisi"

@onready var sfx_player: AudioStreamPlayer2D = $"../../SfxPlayer"
@onready var sfx_player_2: AudioStreamPlayer2D = $"../../SfxPlayer2"

@onready var cinematic_player: CinematicPlayer = $"../CinematicPlayer"

func _ready() -> void:
	if PuzzleManager.complete_puzzles[PuzzleManager.puzzles.DEATH] == true:
		death.disabled = true

func _on_grimoire_pressed() -> void:
	if PuzzleManager.completed_puzzles == PuzzleManager.number_of_puzzles - 1:
		disable_buttons()
		PuzzleManager.finish_puzzle(PuzzleManager.puzzles.WORLD)
		sfx_player.play()
		TextManager.show_once("World_completed", [
			"A mirror only shatters when its work is done!"
		])
		SignalBus.world_completed.emit()
		sfx_player_2.play()
		await get_tree().create_timer(2).timeout
		
		cinematic_player.show()
		cinematic_player.play_outro()
		
		await cinematic_player.cinematic_finished
		
		DirAccess.remove_absolute("user://SaveFile.tres")
		SceneChanger.change_scene_to_path("res://scenes/2d/main_menu.tscn")
	else:
		TextManager.show_once("World_empty", [
			"The Grimoire is silent. I need to find the rest of the cards before I even think about starting the spell."
		])
		
func disable_buttons():
	death.disabled = true
	grimoire.disabled = true
	pisi.disabled = true
