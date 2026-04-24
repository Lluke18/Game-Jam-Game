class_name Card

extends TextureRect

func fade_in():
	modulate.a = 0.0
	visible = true
	var tween = create_tween()
	tween.tween_property(self, "modulate:a", 1.0, 1.0)

func fade_out():
	var tween = create_tween()
	tween.tween_property(self, "modulate:a", 0.0, 1.0)
	
func play_fade_sequence():
	fade_in()
	await get_tree().create_timer(2).timeout
	fade_out()
