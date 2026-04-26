extends Button

@export var destination_room_path : String = ""
@export var zoom_multiplier: float = 1.2


func _ready() -> void:
	mouse_entered.connect(_on_mouse_entered)
	mouse_exited.connect(_on_mouse_exited)



func _on_mouse_entered() -> void:
	print("mouse entered!")
	if disabled == true:
		return
	scale = Vector2(zoom_multiplier,zoom_multiplier)
	pivot_offset = size / 2

func _on_mouse_exited() -> void:
	scale = Vector2(1,1)
	pivot_offset = size / 2
