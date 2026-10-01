extends Node

enum puzzles{
	MAGICIAN,
	HIEROPHANT,
	STAR,
	DEATH,
	TEMPERANCE,
	MOON,
	SUN,
	EMPEROR,
	JUDGEMENT,
	WORLD,
	FOOL,
}

var moon_symbol_picked_up: bool = false
var pencil_picked_up: bool = false
var calendar_solved: bool = false
var chest_opened : bool = false

var blue_pot_picked_up: bool = false
var green_pot_picked_up: bool = false
var yellow_pot_picked_up: bool = false

var small_sack_picked_up: bool = false
var medium_sack_picked_up: bool = false
var big_sack_picked_up: bool = false

var all_sacks_picked_up: bool = false

var _2_petal_placed: bool = false
var _3_petal_placed: bool = false
var _4_petal_placed: bool = false
var suncenter_placed: bool = false

var verses_discovered: Array[bool] = [false, false, false, false]

var candles_lit: Array[bool] = [false, false, false, false]

const number_of_puzzles: int = 11
var complete_puzzles: Array[bool] = []
var completed_puzzles : int = 0

#region GARDEN VARS
var has_gate_key : bool = false #for testin
var gate_opened: bool = false
var has_worm : bool = false
var worm_placed: bool = false
var sunflower_picked: bool = false
var came_from_greenhouse: bool = false
#endregion



signal puzzle_finished(puzzle_index: int)
signal all_puzzles_completed
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	# For testing purposes ONLY
	#reset_data()
	#complete_puzzles[puzzles.MAGICIAN] = true
	
	SignalBus.connect("magician_completed", check_cards)
	SignalBus.connect("death_completed", check_cards)
	SignalBus.connect("moon_completed", check_cards)
	SignalBus.connect("temperance_completed", check_cards)
	SignalBus.connect("star_completed", check_cards)
	SignalBus.connect("hierophant_completed", check_cards)
	SignalBus.connect("world_completed", check_cards)
	
func check_cards():
	completed_puzzles += 1
	if completed_puzzles == 6:
		all_puzzles_completed.emit()
		print("LIGHTS OFF! SECRET DOOR OPENED!")
	print("puzzle count:", completed_puzzles)

func finish_puzzle(puzzle_index: int):
	complete_puzzles[puzzle_index] = true
	SaveManager.save_file_data.complete_puzzles[puzzle_index] = true
	puzzle_finished.emit(puzzle_index)
	
func reset_data():
	moon_symbol_picked_up = false
	pencil_picked_up = false
	calendar_solved = false
	chest_opened = false
	
	blue_pot_picked_up = false
	green_pot_picked_up = false
	yellow_pot_picked_up = false

	small_sack_picked_up = false
	medium_sack_picked_up = false
	big_sack_picked_up = false
	
	all_sacks_picked_up = false
	
	_2_petal_placed = false
	_3_petal_placed = false
	_4_petal_placed = false
	suncenter_placed = false
	
	has_gate_key = false
	gate_opened = false
	has_worm = false
	worm_placed = false
	sunflower_picked = false
	came_from_greenhouse = false

	verses_discovered.fill(false)

	candles_lit.fill(false)
	
	complete_puzzles = []
	complete_puzzles.resize(number_of_puzzles)
	complete_puzzles.fill(false)
	
	SaveManager.save_file_data.complete_puzzles.resize(number_of_puzzles)
	SaveManager.save_file_data.complete_puzzles.fill(false)
	
	completed_puzzles = 0

func load_data():
	moon_symbol_picked_up = SaveManager.save_file_data.moon_symbol_picked_up
	pencil_picked_up = SaveManager.save_file_data.pencil_picked_up
	calendar_solved = SaveManager.save_file_data.calendar_solved
	chest_opened = SaveManager.save_file_data.chest_opened
	
	blue_pot_picked_up = SaveManager.save_file_data.blue_pot_picked_up
	green_pot_picked_up = SaveManager.save_file_data.green_pot_picked_up
	yellow_pot_picked_up = SaveManager.save_file_data.yellow_pot_picked_up

	small_sack_picked_up = SaveManager.save_file_data.small_sack_picked_up
	medium_sack_picked_up = SaveManager.save_file_data.medium_sack_picked_up
	big_sack_picked_up = SaveManager.save_file_data.big_sack_picked_up
	
	all_sacks_picked_up = SaveManager.save_file_data.all_sacks_picked_up
	
	complete_puzzles = SaveManager.save_file_data.complete_puzzles
	completed_puzzles = 0
	for puzzle in complete_puzzles:
		if puzzle == true:
			completed_puzzles += 1
