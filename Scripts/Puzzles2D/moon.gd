extends Node

@onready var item_drop_area: ItemDropArea = $ItemDropArea
@onready var moon_stand_sprite: Sprite2D = $MoonStandSprite
@onready var sfx_player: AudioStreamPlayer2D = $Sfx_Player

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	item_drop_area.area_complete.connect(end_puzzle)
	if PuzzleManager.complete_puzzles[PuzzleManager.puzzles.MOON] == true:
		fill_moon_stand()

func end_puzzle():
	print("The Moon finished!")
	PuzzleManager.finish_puzzle(PuzzleManager.puzzles.MOON)
	sfx_player.play()
	TextManager.show_once("Moon_completed" , [
		"The Moon. Number eighteen. Illusion and anxiety... fitting. So all the cards are scattered between these mirrored realities."
	])
	SignalBus.moon_completed.emit()
	fill_moon_stand()
	
func fill_moon_stand():
	moon_stand_sprite.texture = load("res://Sprites/Background/MoonStandComplete.png")
	
	#disable item_drop_area so it can no longer receive items
	item_drop_area.visible = false
