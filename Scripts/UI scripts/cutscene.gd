extends CanvasLayer

@onready var background : ColorRect = $ColorRect

var lines = [
	{"text": "Undeva, departe de lume...", "position": Vector2(200, 100)},
	{"text": "Un vrăjitor trăia singur.", "position": Vector2(500, 200)},
	{"text": "Dar ceva nu era în regulă.", "position": Vector2(300, 320)},
	{"text": "Lucrurile din casă... se mișcau.", "position": Vector2(600, 430)},
	{"text": "Și nimeni nu știa de ce.", "position": Vector2(250, 540)},
]

func _ready() -> void:
	hide()

func play(next_scene: String) -> void:
	show()
	background.modulate.a = 0.0
	
	var tween = create_tween()
	tween.tween_property(background, "modulate:a", 1.0, 1.0)
	await tween.finished
	
	for line in lines:
		await show_line(line["text"], line["position"])
		await get_tree().create_timer(1.5).timeout
	
	await get_tree().create_timer(3.0).timeout
	
	var tween2 = create_tween()
	tween2.tween_property(background, "modulate:a", 0.0, 1.0)
	await tween2.finished
	
	get_tree().change_scene_to_file(next_scene)

func show_line(text: String, pos: Vector2) -> void:
	var label = Label.new()
	label.text = text
	label.position = pos
	label.modulate.a = 0.0
	background.add_child(label)
	
	var tween = create_tween()
	tween.tween_property(label, "modulate:a", 1.0, 0.8)
	await tween.finished
