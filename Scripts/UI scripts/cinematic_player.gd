class_name CinematicPlayer

extends VideoStreamPlayer

@export var intro_video: VideoStreamTheora
@export var outro_video: VideoStreamTheora

@onready var skip: Button = $Skip
@onready var animation_player: AnimationPlayer = $AnimationPlayer

signal cinematic_finished

func _ready() -> void:
	skip.hide()
	skip.disabled = true
	self_modulate.a = 0

func play_intro():
	AudioManager.stop_music()
	#Ca sa reia muzica de la inceput dupa ce se termina cinematicul
	AudioManager.is_3d = true
	animation_player.play("fade_to_black")
	await animation_player.animation_finished
	
	self_modulate.a = 1
	stream = intro_video
	play()
	skip.show()
	
	animation_player.play("fade_to_normal")
	await animation_player.animation_finished
	
	skip.disabled = false

func play_outro():
	AudioManager.stop_music()
	#Ca sa reia muzica de la inceput dupa ce se termina cinematicul
	AudioManager.is_3d = true
	animation_player.play("fade_to_black")
	await animation_player.animation_finished
	
	self_modulate.a = 1
	stream = outro_video
	play()
	skip.show()
	
	animation_player.play("fade_to_normal")
	await animation_player.animation_finished
	
	skip.disabled = false

func _on_skip_pressed() -> void:
	stop()
	finished.emit()

func _on_finished() -> void:
	skip.disabled = true
	
	animation_player.play("fade_to_black")
	await animation_player.animation_finished
	
	self_modulate.a = 0
	cinematic_finished.emit()
