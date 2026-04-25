extends Node3D

class_name CypherWheel

@export var angles: Array[float]
@export var offsets: Array[float]
var curr_index : int = 0

func spin():
	self.global_rotation.z = angles[curr_index] + offsets[curr_index]
	if curr_index >= 3:
		curr_index = 0
	else:
		curr_index += 1
	print(global_rotation_degrees)
	
