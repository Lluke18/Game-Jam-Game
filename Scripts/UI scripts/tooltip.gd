class_name Tooltip

extends Control

@onready var label: Label = $VBoxContainer/Label

func set_text(text: String):
	label = $VBoxContainer/Label
	label.text = text
