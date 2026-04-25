extends Node

@onready var keyboard: Node = $CanvasLayer/Keyboard
@onready var typed_text: Label = $CanvasLayer/Panel/Password
@onready var sfx_player: AudioStreamPlayer2D = $Sfx_Player

@export var solution: String

func _ready() -> void:
	connect_key_signals()
	TextManager.show_once("Death" , [
		"I wonder what the code is"
	])

func connect_key_signals():
	for key in keyboard.get_children():
		if key is KeyboardKey:
			key.keyboard_input.connect(on_keyboard_input)
			
func disconnect_key_signals():
	for key in keyboard.get_children():
		if key is KeyboardKey:
			key.keyboard_input.disconnect(on_keyboard_input)

func check_typed_text():
	if typed_text.text == solution:
		print("Death finished!")
		PuzzleManager.finish_puzzle(PuzzleManager.puzzles.DEATH)
		SignalBus.death_completed.emit()
		PuzzleManager.death_solved = true
		sfx_player.play()
		TextManager.show_once("Death_completed", [
		"Death. Number thirteen. Everyone panics when they see this one,", 
		"but it’s rarely about the literal end. It’s just... a transition.", 
		"A total change of state. Given the mess I’m in." ,
		"I guess out with the old is the only way forward."
	])
		disconnect_key_signals()
	else:
		print("Wrong password!")
		typed_text = typed_text.left(-1 * solution.length())

func on_keyboard_input(input: String):
	if input == "<-" and typed_text.length() > 0:
		typed_text = typed_text.left(-1)
		update_displayed_letters()
		
	if input != "<-":
		typed_text.text += input
		update_displayed_letters()
		if typed_text.length() == solution.length():
			check_typed_text()
			
func update_displayed_letters():
	var letter_index: int = 0
	print(typed_text.text)
	for letter in typed_text.get_children():
		if letter is Label:
			letter.text = typed_text.text[letter_index]
			letter_index += 1
