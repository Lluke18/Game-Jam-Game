extends Node

var active : bool = false
var shown_dialogues : Array[String] = []

signal start_dialogue(text: String)
signal dialogue_finished

func show_text(text: String) -> void:
	start_dialogue.emit(text)

func show_sequence(texts: Array[String]) -> void:
	active = true
	for text in texts:
		if not active:
			break
		start_dialogue.emit(text)
		await dialogue_finished

func show_once(id: String, texts: Array[String]) -> void:
	if id in shown_dialogues:
		return
	shown_dialogues.append(id)
	show_sequence(texts)

func cancel() -> void:
	active = false
	DialogueBox.clear()
