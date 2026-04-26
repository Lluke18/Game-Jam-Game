extends Node3D

@export var spawnpos : Marker3D
@export var player : CharacterBody3D
@export var scene_2D_path : String 

#var can_interact : bool = false
@export var mirror : InteractableObject
@export var zodiac_wheel : InteractableObject
@export var zodiac_tile : Node3D 
#@export var moon_symbol : InteractableObject
@export var placeholder_item : ItemData
@export var zoom_camera : Camera3D
@onready var dissolve: ColorRect = $dissolve
@onready var animation_player: AnimationPlayer = $AnimationPlayer



func _ready() -> void:
	dissolve.visible = false
	print(mirror.area.can_interact)
	player.global_position = spawnpos.position
	mirror.interact = Callable(self, "_on_mirror_switch")
	TextManager.show_once("mainroom_enter", [
		"What is this place? Looks like some wizard’s room.	", 
		"I see the moon from the mirror,but can I get back to my world?"
	])
	zoom_camera.canvas.visible = false


func _on_mirror_switch():
	print("SWITCHING!")
	
	
	mirror.area.can_interact = false
	print(mirror.area.can_interact)
	player.set_physics_process(false)
	dissolve.visible = true
	animation_player.play("dissolve")
	await animation_player.animation_finished
	SceneChanger.change_scene_to_path.call_deferred(scene_2D_path)

func _on_player_clicked(target) -> void:
	if not target.area:
		target.interact.call()
	elif target.area.can_interact:
		print("target is in area!")
		target.interact.call()


#func _on_moon_pickup():
	#InventoryManager.add_item(InventoryManager.ITEM3)
	#moon_symbol.queue_free()
