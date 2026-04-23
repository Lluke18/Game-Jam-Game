class_name DraggablePuzzleObject

extends TextureButton

var isDragging: bool = false
var draggable: bool = true
var offset: Vector2 = Vector2(0,0)

@export var index: int = 0
signal try_snapping(index: int)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if isDragging and draggable:
		global_position = get_global_mouse_position() - offset

func _on_button_down() -> void:
	isDragging = true
	offset = get_global_mouse_position() - global_position

func _on_button_up() -> void:
	isDragging = false
	try_snapping.emit(index)
