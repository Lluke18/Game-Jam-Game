extends CanvasLayer

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@export var destination_room_path : String

@onready var dissolve: ColorRect = $dissolve


func _ready():
	dissolve.visible = false

func _on_mirror_pressed() -> void:
	if destination_room_path != "":
		dissolve.visible = true
		print("playing anim...")
		animation_player.play("dissolve")
		await animation_player.animation_finished
		SceneChanger.change_scene_to_path(destination_room_path)
