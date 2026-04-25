extends Node3D

@export var anim_player : AnimationPlayer
var skip_animation : bool = false

func open_chest():
	anim_player.play("chest_open")
	if skip_animation:
		anim_player.seek(anim_player.current_animation_length, true)
