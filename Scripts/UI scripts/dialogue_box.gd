extends CanvasLayer

@onready var text_label : Label = $PanelContainer/MarginContainer/HBoxContainer/Label

var is_typing : bool = false
var full_text : String = ""
var typing : bool = false

func _ready() -> void:
	hide()
	TextManager.start_dialogue.connect(_on_start_dialogue)
	print("DialogueBox ready, connected to TextManager")

func _on_start_dialogue(text: String) -> void:
	print("_on_start_dialogue apelat cu: ", text)
	typing = false
	await get_tree().process_frame
	show()
	full_text = text
	text_label.text = ""
	is_typing = true
	_type_text()

func clear() -> void:
	hide()
	text_label.text = ""
	is_typing = false
	full_text = ""

func _type_text() -> void:
	typing = true
	var i = 0
	while i<full_text.length():
		if not typing:
			break
		text_label.text += full_text[i]
		i += 1
		await get_tree().create_timer(0.05).timeout
	typing = false
	is_typing = false
	await get_tree().create_timer(2.0).timeout
	if not typing:
		hide()
		TextManager.dialogue_finished.emit()
