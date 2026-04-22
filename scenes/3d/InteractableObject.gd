extends Node3D

class_name InteractableObject

@export var area : InteractableArea3D
@export var object : PhysicsBody3D
#signal interacted
var interact : Callable = func() : pass


#func interact():
#	pass
