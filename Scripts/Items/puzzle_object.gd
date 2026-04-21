extends TextureButton

var isDragging: bool = false
var offset: Vector2 = Vector2(0,0)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if isDragging:
		global_position = get_global_mouse_position() - offset

func _on_button_down() -> void:
	isDragging = true
	offset = get_global_mouse_position() - global_position

func _on_button_up() -> void:
	isDragging = false
