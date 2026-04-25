extends Node

@onready var cypher_chest : InteractableObject = $StaticBody3D
@export var zoom_camera : Camera3D 
@export var player : CharacterBody3D
@export var actual_chest : Node3D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if PuzzleManager.complete_puzzles[PuzzleManager.puzzles.TEMPERANCE] == false:
		cypher_chest.interact = Callable(self, "_on_chest_clicked")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_chest_clicked():
	print("lock zoomed!")
	zoom_camera.make_current()
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	zoom_camera.canvas.visible = true


func _on_zoom_camera_cypher_cracked() -> void:
	SignalBus.temperance_completed.emit()
	PuzzleManager.chest_opened = true
	print("opening chest!")
	actual_chest.open_chest()
