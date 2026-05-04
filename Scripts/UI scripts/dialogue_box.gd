extends CanvasLayer

@onready var text_label : Label = $PanelContainer/MarginContainer/HBoxContainer/Label
@onready var skip_button: Button = $Skip

var _typing_speed : float = 30.0
var _typing_time : float = 0.0
var is_typing : bool = false
var current_id : int = 0

func _ready() -> void:
	hide()
	TextManager.start_dialogue.connect(_on_start_dialogue)
	skip_button.pressed.connect(_on_skip_pressed)

func _on_skip_pressed() -> void:
	if is_typing:
		text_label.visible_characters = -1
		is_typing = false
		current_id += 1
		await get_tree().create_timer(2.5).timeout
		hide()
		TextManager.dialogue_finished.emit()

func _on_start_dialogue(text: String) -> void:
	current_id += 1
	var my_id = current_id
	is_typing = false
	await get_tree().process_frame
	if my_id != current_id:
		return
	show()
	display_text(text, my_id)

func display_text(text: String, id: int) -> void:
	text_label.text = text
	text_label.visible_characters = 0
	_typing_time = 0.0
	is_typing = true
	while text_label.visible_characters < text_label.get_total_character_count():
		if id != current_id:
			return
		_typing_time += get_process_delta_time()
		text_label.visible_characters = int(_typing_speed * _typing_time)
		await get_tree().process_frame
	is_typing = false
	await get_tree().create_timer(2.0).timeout
	if id != current_id:
		return
	if not is_typing:
		hide()
		TextManager.dialogue_finished.emit()

func clear() -> void:
	current_id += 1
	hide()
	text_label.text = ""
	text_label.visible_characters = 0
	is_typing = false
