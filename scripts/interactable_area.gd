extends Area2D

class_name InteractArea

@export var action_name : String = "interact"
var area_active : bool = false # THIS IS FOR THE SIMPLER MODE

var interact: Callable = func(): pass #this one is important

func _on_mouse_entered() -> void:
	print("mouse entered!")
	InteractionManager.register_area(self)
	area_active = true


func _on_mouse_exited() -> void:
	print("mouse exited!")
	InteractionManager.unregister_area(self)
	area_active = false
