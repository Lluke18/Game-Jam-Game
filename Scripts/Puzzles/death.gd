extends Node

@onready var keyboard: Node = $CanvasLayer/Keyboard
@onready var typed_text: Label = $CanvasLayer/Panel/Password

@export var solution: String

func _ready() -> void:
	connect_key_signals()

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
		PuzzleManager.complete_puzzles[PuzzleManager.puzzles.DEATH] = true
		SignalBus.death_completed.emit()
		disconnect_key_signals()
	else:
		print("Wrong password!")
		typed_text.text = typed_text.text.left(-1 * solution.length())

func on_keyboard_input(input: String):
	if input == "<-" and typed_text.text.length() > 0:
		typed_text.text = typed_text.text.left(-1)
		
	if input != "<-":
		typed_text.text += input
		if typed_text.text.length() == solution.length():
			check_typed_text()
