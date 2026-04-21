extends Node

var obtained_items: Array[ItemData] = []

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	obtained_items.resize(10)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
