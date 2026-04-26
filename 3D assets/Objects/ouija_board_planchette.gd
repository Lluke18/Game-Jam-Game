extends Node3D

@onready var anim : Animation = $AnimationPlayer.get_animation("Planchette_animation")
@onready var anim_player := $AnimationPlayer

func _ready() -> void:
	if !PuzzleManager.complete_puzzles[PuzzleManager.puzzles.DEATH]:
		await get_tree().create_timer(2).timeout
		anim.loop_mode = Animation.LOOP_LINEAR
		anim_player.play("Planchette_animation")
