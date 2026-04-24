class_name DrawingDot

extends TextureButton

@export var target_indexes: Array[int] = []
@export var index: int = 0

signal draw_attempt(origin_dot_index: int)
signal draw_stop(origin_dot_index: int)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func _on_button_down() -> void:
	draw_attempt.emit(index)

func _on_button_up() -> void:
	draw_stop.emit(index)
