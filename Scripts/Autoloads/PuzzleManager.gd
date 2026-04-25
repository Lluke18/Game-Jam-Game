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
var pencil_picked_up: bool = false
var calendar_solved: bool = false
var chest_opened : bool = false
var temperance_solved : bool = false

var blue_pot_picked_up: bool = false
var green_pot_picked_up: bool = false
var yellow_pot_picked_up: bool = false

var small_sack_picked_up: bool = false
var medium_sack_picked_up: bool = false
var big_sack_picked_up: bool = false

var death_solved : bool = false

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

func finish_puzzle(puzzle_index: int):
	complete_puzzles[puzzle_index] = true
	puzzle_finished.emit(puzzle_index)
	
func reset_data():
	moon_symbol_picked_up = false
	pencil_picked_up = false
	calendar_solved = false
	
	blue_pot_picked_up = false
	green_pot_picked_up = false
	yellow_pot_picked_up = false

	small_sack_picked_up = false
	medium_sack_picked_up = false
	big_sack_picked_up = false
	
	complete_puzzles = []
	complete_puzzles.resize(number_of_puzzles)
	complete_puzzles.fill(false)
	completed_puzzles = 0

func load_data():
	moon_symbol_picked_up = SaveManager.save_file_data.moon_symbol_picked_up
	pencil_picked_up = SaveManager.save_file_data.pencil_picked_up
	calendar_solved = SaveManager.save_file_data.calendar_solved
	
	blue_pot_picked_up = SaveManager.save_file_data.blue_pot_picked_up
	green_pot_picked_up = SaveManager.save_file_data.green_pot_picked_up
	yellow_pot_picked_up = SaveManager.save_file_data.yellow_pot_picked_up

	small_sack_picked_up = SaveManager.save_file_data.small_sack_picked_up
	medium_sack_picked_up = SaveManager.save_file_data.medium_sack_picked_up
	big_sack_picked_up = SaveManager.save_file_data.big_sack_picked_up
	
	complete_puzzles = SaveManager.save_file_data.complete_puzzles
	completed_puzzles = 0
	for puzzle in complete_puzzles:
		if puzzle == true:
			completed_puzzles += 1
