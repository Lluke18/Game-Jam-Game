extends Node
@export var ouija_table : Node3D


func _ready() -> void:
	if PuzzleManager.complete_puzzles[PuzzleManager.puzzles.DEATH]:
		print("DEATH IS SOLVED, NO ANIMATION!")
		stop_animation()


func stop_animation():
	ouija_table.anim_player.stop()
