extends Node3D

@export var spawnpos : Marker3D
@export var player : CharacterBody3D
@export var scene_2D_path : String 

var can_interact : bool = false

func _ready() -> void:
	player.global_position = spawnpos.position


func _on_d_mirror_body_entered(body: Node3D) -> void:
	if body is CharacterBody3D:
		print("entered!")
		can_interact = true


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("interact") and can_interact:
		print("SWITCHING!")
		SceneChanger.change_scene_to_path(scene_2D_path)
