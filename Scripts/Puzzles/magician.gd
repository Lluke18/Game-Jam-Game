extends Node2D

@onready var snap_markers: Node = $CanvasLayer/SnapMarkers
@onready var paintings_parent: Node = $CanvasLayer/Paintings

var markers: Array[Marker2D] = []
var paintings: Array[DraggablePuzzleObject] = []
var paintings_snapped: Array[int] = []
var room1_path : String = "res://Rooms/Room1.tscn"
@export var snap_max_distance: float = 100.0

func _ready() -> void:
	init_markers_array()
	init_paintings_array()
	init_paintings_snapped_array()
		
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
		painting.try_snapping.disconnect(on_try_snapping)
	print("The Magician finished!")
	PuzzleManager.complete_puzzles[PuzzleManager.puzzles.MAGICIAN] = true
	SignalBus.magician_completed.emit()
	await get_tree().create_timer(2).timeout
	SceneChanger.change_scene_to_path(room1_path)

func on_try_snapping(painting_index: int):
	for marker_index in range(markers.size()):
		if paintings[painting_index].global_position.distance_to(markers[marker_index].global_position) < snap_max_distance:
			if paintings_snapped.has(marker_index):
				return
			paintings_snapped[painting_index] = marker_index
			paintings[painting_index].global_position = markers[marker_index].global_position
			check_if_solved()
			return
	paintings_snapped[painting_index] = -1
