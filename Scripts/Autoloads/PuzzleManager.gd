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

var moon_symbol_picked_up: bool = false

const number_of_puzzles: int = 7
var complete_puzzles: Array[bool] = []
var completed_puzzles : int = 0

signal puzzle_finished(puzzle_index: int)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
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
		
func finish_puzzle(puzzle_index: int):
	complete_puzzles[puzzle_index] = true
	puzzle_finished.emit(puzzle_index)
	
func reset_data():
	complete_puzzles = []
	complete_puzzles.resize(number_of_puzzles)
	complete_puzzles.fill(false)
	completed_puzzles = 0

func load_data():
	complete_puzzles = SaveManager.save_file_data.complete_puzzles
	completed_puzzles = 0
	for puzzle in complete_puzzles:
		if puzzle == true:
			completed_puzzles += 1
