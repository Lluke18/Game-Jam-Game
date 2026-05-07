extends Button

@export var destination_room_path : String = ""
@export var zoom_multiplier: float = 1.2

@onready var purr_sound: AudioStreamPlayer2D = $"purr_sound"
@onready var special_sound: AudioStreamPlayer2D = $"special_sound"

var click_count : int = 0

var random_messages: Array[String] = [
	"I love my little Jinx.",
	"She wants more pets.",
	"She blinked at me. That means love.",
	"She's starting to purr...",
	"Keep going...",
	"She rolled over. Time for more pets.",
	"*purring intensifies*"
]

func _ready() -> void:
	mouse_entered.connect(_on_mouse_entered)
	mouse_exited.connect(_on_mouse_exited)

func _on_pressed() -> void:
	if destination_room_path != "":
		SceneChanger.change_scene_to_path(destination_room_path)
		return
	
	click_count += 1
	
	if click_count == 6:
		special_sound.play()
		TextManager.show_text("So cute.")
		click_count = 0
	else:
		purr_sound.play()
		TextManager.show_text(random_messages[randi() % random_messages.size()])

func _on_mouse_entered() -> void:
	if disabled == true:
		return
	scale = Vector2(zoom_multiplier, zoom_multiplier)
	pivot_offset = size / 2

func _on_mouse_exited() -> void:
	scale = Vector2(1, 1)
	pivot_offset = size / 2
