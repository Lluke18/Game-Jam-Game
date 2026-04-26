extends Node

@onready var the_magician: Button = $"The Magician"

@export var a_sprite: Sprite2D
@export var d_sprite: Sprite2D

func _ready() -> void:
	if PuzzleManager.complete_puzzles[PuzzleManager.puzzles.MAGICIAN] == true:
		the_magician.disabled = true
		a_sprite.visible = true
		d_sprite.visible = true
	else:
		a_sprite.visible = false
		d_sprite.visible = false
