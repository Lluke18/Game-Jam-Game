class_name DraggablePuzzleObject

extends TextureButton

var is_dragging: bool = false
var draggable: bool = true
var offset: Vector2 = Vector2(0,0)

@export var index: int = 0
signal try_snapping(index: int)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if is_dragging and draggable:
		global_position.x = clamp(get_global_mouse_position().x - offset.x, 0, 1600)
		global_position.y = clamp(get_global_mouse_position().y - offset.y, 0, 800)

func _on_button_down() -> void:
	is_dragging = true
	offset = get_global_mouse_position() - global_position

func _on_button_up() -> void:
	is_dragging = false
	try_snapping.emit(index)
