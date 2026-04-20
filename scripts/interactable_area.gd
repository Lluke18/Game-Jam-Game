extends Area2D

class_name InteractArea

@export var action_name : String = "interact"
var area_active : bool = false # THIS IS FOR THE SIMPLER MODE

var interact: Callable = func(): pass #this one is important

func _on_body_entered(body: Node2D) -> void:
	InteractionManager.register_area(self)
	area_active = true

func _on_body_exited(body: Node2D) -> void:
	InteractionManager.unregister_area(self)
	area_active = false
