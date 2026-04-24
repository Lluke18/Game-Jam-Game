extends Node3D

@export var anim_player : AnimationPlayer
#@onready var animation : Animation = $"../AnimationPlayer".get_animation("aries_falling")
@export var star_card : MeshInstance3D

var skip_animation: bool = false

func _ready() -> void:
	#area.hide()
	pass

func aries_fall():
	print("its falling!")
	
	anim_player.play("aries_falling")
	if skip_animation:
		anim_player.seek(anim_player.current_animation_length, true)
	#area.show()
