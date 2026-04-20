extends Node2D

const base_text := "[click to use]"
var active_areas = []

func register_area(area: InteractArea):
	active_areas.push_back(area)

func unregister_area(area: InteractArea):
	var index = active_areas.find(area)
	if index != -1:
		active_areas.remove_at(index)

func _input(event: InputEvent) -> void:
	#we have to implement the mouse functionality as an action
	if event.is_action_released("interact"):
		if active_areas.size()>0:
			await get_tree().process_frame
			await active_areas[0].interact.call()
			await get_tree().process_frame
