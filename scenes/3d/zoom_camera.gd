extends Camera3D

@export var canvas : CanvasLayer

@export var player : CharacterBody3D
@export var butt1 : TextureButton
@export var butt2 : TextureButton
@export var butt3 : TextureButton
@export var butt4 : TextureButton

signal cypher_cracked

enum runes{FIRST, SECOND, THIRD, FOURTH}

var wheel_arr : Array[int] = [0, 1, 2, 3]
@export var texture_array : Array[Texture]
@export var sol_arr : Array[runes]
var curr_arr : Array[runes]

func _ready():
	curr_arr.resize(4)
	curr_arr.fill(runes.THIRD)

func _on_exit_pressed() -> void:
	player.camera.make_current()
	canvas.visible = false
	player.canvas_layer.visible = true
	PauseMenu.is_in_chest = false
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)


func check_puzzle():
	for rune_index in range(curr_arr.size()):
		if curr_arr[rune_index] != sol_arr[rune_index]:
			print("wrong!")
			return
	cypher_cracked.emit()
	TextManager.show_once("Chest_Finished" , [
		"Weights, they definitely are for the balance."
	])
	print("solved!")

func _on_button_pressed() -> void:
	if curr_arr[0] == runes.FOURTH:
		curr_arr[0] = runes.FIRST
	else:
		curr_arr[0] += 1
	print(curr_arr)
	butt1.texture_normal = texture_array[curr_arr[0]]
	check_puzzle()
	

func _on_button_2_pressed() -> void:
	if curr_arr[1] == runes.FOURTH:
		curr_arr[1] = runes.FIRST
	else:
		curr_arr[1] += 1
	print(curr_arr)
	butt2.texture_normal = texture_array[curr_arr[1]]
	check_puzzle()
	
func _on_button_3_pressed() -> void:
	if curr_arr[2] == runes.FOURTH:
		curr_arr[2] = runes.FIRST
	else:
		curr_arr[2] += 1
	print(curr_arr)
	butt3.texture_normal = texture_array[curr_arr[2]]
	check_puzzle()
	
func _on_button_4_pressed() -> void:
	if curr_arr[3] == runes.FOURTH:
		curr_arr[3] = runes.FIRST
	else:
		curr_arr[3] += 1
	print(curr_arr)
	butt4.texture_normal = texture_array[curr_arr[3]]
	check_puzzle()


func _on_hint_pressed() -> void:
	TextManager.show_text("I should look more closely at the runes.")
