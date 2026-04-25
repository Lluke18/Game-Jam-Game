extends Camera3D

@export var canvas : CanvasLayer

@export var player : CharacterBody3D
signal cypher_cracked

enum runes{FIRST, SECOND, THIRD, FOURTH}

@export var texture_array : Array[Texture]
@export var sol_arr : Array[runes]
var curr_arr : Array[runes]



func _on_exit_pressed() -> void:
	player.camera.make_current()
	canvas.visible = false
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)


func check_puzzle():
	for rune_index in range(curr_arr.size()):
		if curr_arr[rune_index] != sol_arr[rune_index]:
			print("wrong!")
			return
	cypher_cracked.emit()
	print("solved!")



func _on_button_pressed() -> void:
	pass # Replace with function body.


func _on_button_2_pressed() -> void:
	pass # Replace with function body.
	
	
func _on_button_3_pressed() -> void:
	pass # Replace with function body.
	
	
func _on_button_4_pressed() -> void:
	pass # Replace with function body.
