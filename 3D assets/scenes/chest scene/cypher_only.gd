extends Node3D

class_name Cypher

@export var first : MeshInstance3D
@export var second : MeshInstance3D
@export var third : MeshInstance3D
@export var fourth : MeshInstance3D

@export var wheel_arr : Array[MeshInstance3D]


@export var rotations_values : Array[Vector3]

enum runes{FIRST, SECOND, THIRD, FOURTH}

@export var sol_arr : Array[runes]
var curr_arr : Array[runes]

func _ready():
	curr_arr.resize(4)
	curr_arr.fill(runes.FIRST)

func spin(wheel_index : int):
	if curr_arr[wheel_index] == runes.FOURTH:
		curr_arr[wheel_index] = runes.FIRST
	else:
		curr_arr[wheel_index] += 1
	print("current index is: ", curr_arr[wheel_index])
	print(wheel_arr[wheel_index].rotation_degrees)
	wheel_arr[wheel_index].global_rotation = rotations_values[
		curr_arr[wheel_index]
	]
	#wheel_arr[wheel_index].rotation = rotations_values[
		#curr_arr[wheel_index]
	#]
	

func check_puzzle():
	for rune_index in range(curr_arr.size()):
		if curr_arr[rune_index] != sol_arr[rune_index]:
			print("wrong!")
			return
	print("solved!")
