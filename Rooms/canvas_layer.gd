extends CanvasLayer

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@export var destination_room_path : String
@onready var audio_stream_player_2d: AudioStreamPlayer2D = $"../AudioStreamPlayer2D"

@onready var dissolve: ColorRect = $dissolve


func _ready():
	dissolve.visible = false


func _on_mirror_pressed() -> void:
	if destination_room_path != "":
		audio_stream_player_2d.play()
		dissolve.visible = true
		print("playing anim...")
		animation_player.play("dissolve")
		await animation_player.animation_finished
		#process inputs freeze
		SceneChanger.change_scene_to_path(destination_room_path)
