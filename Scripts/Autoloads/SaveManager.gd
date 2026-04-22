extends Node

const save_location = "user://SaveFile.tres"

var save_file_data: SaveData = SaveData.new()

func _ready() -> void:
	load_data()

func save_data():
	ResourceSaver.save(save_file_data, save_location)
	
func load_data():
	if FileAccess.file_exists(save_location):
		save_file_data = ResourceLoader.load(save_location).duplicate(true)
