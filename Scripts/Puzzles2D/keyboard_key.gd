class_name KeyboardKey

extends Node

@export var key_text: String = ""
signal keyboard_input(input: String)

func _on_pressed() -> void:
	keyboard_input.emit(key_text)
