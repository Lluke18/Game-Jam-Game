extends CanvasLayer

@onready var text_label : Label = $PanelContainer/MarginContainer/HBoxContainer/Label

var _typing_speed : float = 60.0
var _typing_time : float = 0.0
var is_typing : bool = false

func _ready() -> void:
	hide()
	TextManager.start_dialogue.connect(_on_start_dialogue)

func _on_start_dialogue(text: String) -> void:
	typing_stopped()
	await get_tree().process_frame
	show()
	display_text(text)

func display_text(text: String) -> void:
	text_label.text = text
	text_label.visible_characters = 0
	_typing_time = 0.0
	is_typing = true
	while text_label.visible_characters < text_label.get_total_character_count():
		_typing_time += get_process_delta_time()
		text_label.visible_characters = _typing_speed * _typing_time as int
		await get_tree().process_frame
	is_typing = false
	await get_tree().create_timer(2.0).timeout
	if not is_typing:
		hide()
		TextManager.dialogue_finished.emit()

func typing_stopped() -> void:
	is_typing = false
	text_label.visible_characters = -1

func clear() -> void:
	hide()
	text_label.text = ""
	text_label.visible_characters = 0
	is_typing = false

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		if is_typing:
			typing_stopped()
