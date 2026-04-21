extends Node3D

@export var spawnpos : Marker3D
@export var player : CharacterBody3D


func _ready() -> void:
	player.global_position = spawnpos.position
