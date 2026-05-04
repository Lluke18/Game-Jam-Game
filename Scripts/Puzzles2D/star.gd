extends Node2D

@onready var target_markers_parent: Node = $CanvasLayer/TargetMarkers
@onready var drawing_dots_parent: Node = $CanvasLayer/DrawingDots
@onready var drawable_lines_parent: Node = $CanvasLayer/DrawableLines

var target_markers: Array[Marker2D] = []
var drawing_dots: Array[DrawingDot] = []

var is_drawing: bool = false

var currently_drawn_line: Line2D = null

@export var snap_max_distance: float = 100.0

func _ready() -> void:
	if PuzzleManager.pencil_picked_up == false:
		InventoryManager.add_item(InventoryManager.PENCIL)
		PuzzleManager.pencil_picked_up = true
		SaveManager.save_file_data.pencil_picked_up = PuzzleManager.pencil_picked_up
	init_target_markers_array()
	init_drawing_dots_array()
	connect_drawing_dots_signals()
	TextManager.show_once("Star" ,[
		"The 16th. My fortieth birthday. I remember that New Moon... it was so dark I couldn't see my own hands. But looking at the other dates, they somehow feel intentional", 
	])
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_pressed("interact") and is_drawing:
		if currently_drawn_line != null:
			currently_drawn_line.set_point_position(1, get_global_mouse_position())

func connect_drawing_dots_signals():
	for dot in drawing_dots:
		dot.draw_attempt.connect(on_draw_attempt)
		dot.draw_stop.connect(on_draw_stop)
		
func disconnect_drawing_dots_signals():
	for dot in drawing_dots:
		dot.draw_attempt.disconnect(on_draw_attempt)
		dot.draw_stop.disconnect(on_draw_stop)
	
func init_target_markers_array():
	for marker in target_markers_parent.get_children():
		if marker is Marker2D:
			target_markers.append(marker)
			
func init_drawing_dots_array():
	for dot in drawing_dots_parent.get_children():
		if dot is DrawingDot:
			drawing_dots.append(dot) 

func on_draw_attempt(origin_dot_index: int):
	var new_line = Line2D.new()
	new_line.add_point(target_markers[origin_dot_index].global_position, 0)
	new_line.add_point(target_markers[origin_dot_index].global_position, 1)
	new_line.default_color = Color(0.976, 0.337, 0.208)
	
	currently_drawn_line = new_line
	drawable_lines_parent.add_child(currently_drawn_line)
	
	is_drawing = true
	
func on_draw_stop(origin_dot_index: int):
	if drawing_dots[origin_dot_index].target_indexes.size() == 0:
		currently_drawn_line.queue_free()
		return
	check_for_targets(origin_dot_index)
	is_drawing = false
	
func check_for_targets(origin_dot_index: int):
	for target_index in range(target_markers.size()):
		if target_index != origin_dot_index:
			if target_markers[target_index].global_position.distance_to(get_global_mouse_position()) < snap_max_distance:
				check_if_valid_target(origin_dot_index, target_index)
				return
	
	#if no target markers found
	currently_drawn_line.queue_free()
	print("Maybe somewhere else...")
			
func check_if_valid_target(origin_dot_index: int, end_dot_index: int):
	if drawing_dots[origin_dot_index].target_indexes.has(end_dot_index):
		drawing_dots[origin_dot_index].target_indexes.erase(end_dot_index)
		drawing_dots[end_dot_index].target_indexes.erase(origin_dot_index)
		currently_drawn_line.set_point_position(1, target_markers[end_dot_index].global_position)
		check_if_complete()
	else:
		#Liniile de cod cu queue_free() inseamna ca player-ul nu a tras linia unde trebuie
		currently_drawn_line.queue_free()
		print("Maybe somewhere else...")
		
func check_if_complete():
	for dot in drawing_dots:
		if dot.target_indexes.size() != 0:
			return
	
	end_puzzle()
	
func end_puzzle():
	PuzzleManager.calendar_solved = true
	TextManager.show_once("Star_completed" ,[
		"This feels familiar… it’s a constellation."
	])
	disconnect_drawing_dots_signals()
	InventoryManager.remove_item(InventoryManager.PENCIL)
