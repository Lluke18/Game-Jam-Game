extends Control

@onready var star: Button = $Star
@onready var books: Button = $Books

@onready var tooltip_scene = preload("res://UI/Tooltip.tscn")
var tooltip: Tooltip

func _process(delta: float) -> void:
	if tooltip:
		tooltip.global_position = get_global_mouse_position() + Vector2(0, -80)

func _ready() -> void:
	if PuzzleManager.calendar_solved == true:
		star.disabled = true
		
func _on_books_mouse_entered() -> void:
	tooltip = tooltip_scene.instantiate()
	tooltip.set_text("Maybe those colors hint to something...")
	add_child(tooltip)
	
func _on_books_mouse_exited() -> void:
	if tooltip:
		tooltip.queue_free()
		tooltip = null
