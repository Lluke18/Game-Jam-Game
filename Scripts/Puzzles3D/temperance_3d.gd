extends Node

@onready var cypher_chest : InteractableObject = $StaticBody3D
@export var zoom_camera : Camera3D 
@export var player : CharacterBody3D
@export var actual_chest : Node3D
@export var static_chest : StaticBody3D
@export var big_sack : Node3D
@export var med_sack : Node3D
@export var small_sack : Node3D

#left taler markers:
@export var left_big_marker : Marker3D
@export var left_med_marker : Marker3D
@export var left_small_marker : Marker3D

#right taler markers:
@export var right_big_marker : Marker3D
@export var right_med_marker : Marker3D
@export var right_small_marker : Marker3D

#sacks:
@export var allsack : InteractableObject
var sack_array := [InventoryManager.BIG_SACK, InventoryManager.MEDIUM_SACK,
					InventoryManager.SMALL_SACK]

#Scales:
@export var left_scale : InteractableObject
@export var right_scale : InteractableObject

var has_left_big_sack : bool = false
var has_right_big_sack: bool = false
var has_med_sack: bool = false
var has_small_sack : bool = false
var is_left : bool = false
var is_right : bool = false


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if !PuzzleManager.temperance_solved:
		left_scale.interact = Callable(self, "_on_lefts_interact")
		right_scale.interact = Callable(self, "_on_rights_interact")
	
	if PuzzleManager.complete_puzzles[PuzzleManager.puzzles.TEMPERANCE] == false:
		cypher_chest.interact = Callable(self, "_on_chest_clicked")
	if PuzzleManager.chest_opened:
		actual_chest.skip_animation = true
		actual_chest.open_chest()
		static_chest.remove_from_group("Interactables")
		zoom_camera.queue_free()
		
		allsack.interact = Callable(self, "_on_all_pickup")
		

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_chest_clicked():
	print("lock zoomed!")
	if zoom_camera:
		zoom_camera.make_current()
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		zoom_camera.canvas.visible = true


func _on_zoom_camera_cypher_cracked() -> void:
	PuzzleManager.chest_opened = true
	
	#things that unlock once chest is opened
	allsack.interact = Callable(self, "_on_all_pickup")

	
	print("opening chest!")
	
	static_chest.remove_from_group("Interactables")
	zoom_camera.queue_free()
	player.camera.make_current()
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	
	await get_tree().create_timer(1).timeout
	actual_chest.open_chest()

func _on_all_pickup():
	print("all picked up!")
	InventoryManager.add_item(InventoryManager.BIG_SACK)
	InventoryManager.add_item(InventoryManager.MEDIUM_SACK)
	InventoryManager.add_item(InventoryManager.SMALL_SACK)
	
	allsack.queue_free()

func _on_lefts_interact():
	print("comparing left")
	if has_left_big_sack:
		InventoryManager.add_item(InventoryManager.BIG_SACK)
		has_left_big_sack = false
		big_sack.visible = false
	
	
	
	if InventoryManager.selected_item == null:
		return
	
	for sack in sack_array:
		if InventoryManager.selected_item.item_name == sack.item_name:
			print("he got away with it!")
			InventoryManager.remove_item(sack)
			is_left = true
			which_sack(sack)
			return
	TextManager.show_once("wrong taler", ["This doesn't belong here.."])
	compare()

func which_sack(sack):
	if sack.item_name == InventoryManager.BIG_SACK.item_name:
		big_sack.visible = true
		if is_left:
			has_left_big_sack = true
			big_sack.global_position = left_big_marker.global_position
			is_left = false
		if is_right:
			has_right_big_sack = true
			big_sack.global_position = right_big_marker.global_position
			is_right = false
		
	elif sack.item_name == InventoryManager.MEDIUM_SACK.item_name:
		has_med_sack = true
		med_sack.visible = true
		if is_left:
			med_sack.global_position = left_med_marker.global_position
			is_left = false
		if is_right:
			med_sack.global_position = right_big_marker.global_position
			is_right = false
		
	elif sack.item_name == InventoryManager.SMALL_SACK.item_name:
		has_small_sack = true
		small_sack.visible = true
		if is_left:
			small_sack.global_position = left_small_marker.global_position
			is_left = false
		if is_right:
			small_sack.global_position = right_small_marker.global_position
			is_right = false
	compare()

func _on_rights_interact():
	print("comparing right")
	
	if has_right_big_sack:
		InventoryManager.add_item(InventoryManager.BIG_SACK)
		has_right_big_sack = false
		big_sack.visible = false
	
	if InventoryManager.selected_item == null:
		return
	
	for sack in sack_array:
		if InventoryManager.selected_item.item_name == sack.item_name:
			print("he got away with it!")
			InventoryManager.remove_item(sack)
			is_right = true
			which_sack(sack)
			return
	TextManager.show_once("wrong taler", ["This doesn't belong here.."])
	


func compare():
	if has_med_sack and has_small_sack:
		if has_left_big_sack or has_right_big_sack:
			print("Temperance completed!")
			left_scale.remove_from_group("Interactables")
			right_scale.remove_from_group("Interactables")
			PuzzleManager.temperance_solved = true
			PuzzleManager.finish_puzzle(PuzzleManager.puzzles.TEMPERANCE)
			SignalBus.temperance_completed.emit()
			
