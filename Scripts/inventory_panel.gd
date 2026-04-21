extends Panel

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.get_current_cursor_shape() == DisplayServer.CURSOR_FORBIDDEN:
		DisplayServer.cursor_set_shape(DisplayServer.CURSOR_ARROW)

var initial_drag_data
func _notification(what: int) -> void:
	if what == Node.NOTIFICATION_DRAG_BEGIN:
		initial_drag_data = get_viewport().gui_get_drag_data()
	if what == Node.NOTIFICATION_DRAG_END:
		if not is_drag_successful():
			if initial_drag_data:
				initial_drag_data.icon.show()
				initial_drag_data = null
