extends Node2D

@onready var snap_markers: Node = $CanvasLayer/SnapMarkers
@onready var paintings_parent: Node = $CanvasLayer/Paintings
@onready var sfx_player: AudioStreamPlayer2D = $Sfx_Player
@onready var back_to_room: Button = $CanvasLayer/SceneSwitchers/BackToRoom
@onready var texture_rect: TextureRect = $CanvasLayer/SceneSwitchers/BackToRoom/TextureRect

var painting_descriptions: Array[String] = [
	"Mom’s favorite photo. She always told people I was a star child.", "She even gave me a name to match “Otto” meaning wealth",
	"Nine years old. I wore that wizard hat for weeks", "The start of the obsession. Should’ve just played football.",
	"Twenty-two. Citrine and aventurine in my pockets for success.","I was sure a degree and a few crystals would do the heavy lifting.",
	"Wait... this isn't supposed to be here. This just happened.", "The mirror... it was glowing exactly like that during the reading."
]
var markers: Array[Marker2D] = []
var paintings: Array[DraggablePuzzleObject] = []
var paintings_snapped: Array[int] = []
var room1_path : String = "res://Rooms/Room1.tscn"
@export var snap_max_distance: float = 100.0

func _ready() -> void:
	back_to_room.disabled = true
	texture_rect.modulate.a = 0.5 
	
	init_markers_array()
	init_paintings_array()
	init_paintings_snapped_array()
	TextManager.show_once("Magician", [
		"I should probably put these back in order.",
		"I don't need my life looking as messy as this room."
	])
		
func init_markers_array():
	for child in snap_markers.get_children():
		if child is Marker2D:
			markers.append(child)
	
func init_paintings_array():
	for child in paintings_parent.get_children():
		if child is DraggablePuzzleObject:
			child.try_snapping.connect(on_try_snapping)
			paintings.append(child)
			
func init_paintings_snapped_array():
	paintings_snapped.resize(paintings.size())
	paintings_snapped.fill(-1)
	
func check_if_solved():
	for painting_index in range(paintings_snapped.size()):
		if paintings_snapped[painting_index] != painting_index:
			return
	end_puzzle()
	
func end_puzzle():
	for painting in paintings:
		painting.draggable = false
		
	print("The Magician finished!")
	sfx_player.play()
	
	TextManager.show_once("Magician_completed", [
		"The Magician. Number one. It’s the card of manifestation",
		"I need the other six if I’m going to fix this mess"
	])
	PuzzleManager.finish_puzzle(PuzzleManager.puzzles.MAGICIAN)
	SignalBus.magician_completed.emit()
	
	await get_tree().create_timer(3.0).timeout 
	back_to_room.disabled = false
	texture_rect.modulate.a = 1

func on_try_snapping(painting_index: int):
	for marker_index in range(markers.size()):
		if paintings[painting_index].global_position.distance_to(markers[marker_index].global_position) < snap_max_distance:
			if paintings_snapped.has(marker_index):
				return
			paintings_snapped[painting_index] = marker_index
			paintings[painting_index].global_position = markers[marker_index].global_position
			if marker_index == painting_index: 
				var texts: Array[String] = [
				painting_descriptions[painting_index * 2],
				painting_descriptions[painting_index * 2 + 1]
	]
				TextManager.show_sequence(texts)
			#await get_tree().create_timer(6.0).timeout 
			check_if_solved()
			return
	paintings_snapped[painting_index] = -1

func _exit_tree() -> void:
	TextManager.cancel()
