extends Node

enum puzzles{
	MAGICIAN,
	MOON,
	DEATH,
	TEMPERANCE,
	STAR,
	HIEROPHANT,
	WORLD
}

const number_of_puzzles: int = 7
var complete_puzzles: Array[bool] = []
var completed_puzzles : int = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	complete_puzzles.resize(number_of_puzzles)
	complete_puzzles.fill(false)
	SignalBus.connect("magician_completed", check_cards)
	SignalBus.connect("death_completed", check_cards)
	SignalBus.connect("moon_completed", check_cards)
	SignalBus.connect("temperance_completed", check_cards)
	SignalBus.connect("star_completed", check_cards)
	SignalBus.connect("hierophant_completed", check_cards)
	SignalBus.connect("world_completed", check_cards)
	
func check_cards():
	completed_puzzles += 1
	print("puzzle count:", completed_puzzles)
	if completed_puzzles == 4: # nrul de puzzleuri complete, pt debug
		print("THE MAGICIAN LONGS TO SEE... FIRE, WALK WITH ME")
	SceneChanger.change_scene_to_path("res://scenes/2d/main_menu.tscn")
	
