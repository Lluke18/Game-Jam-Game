extends Node3D

@export var anim_player : AnimationPlayer


func open_chest():
	anim_player.play("chest_open")
