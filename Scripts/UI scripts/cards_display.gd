extends Node

@onready var small_cards_parent: Panel = $SmallCards
@onready var big_cards_parent: Node = $BigCards

var small_cards: Array[Card] = []
var big_cards: Array[Card] = []

func _ready() -> void:
	init_small_cards()
	init_big_cards()
	update_display()
	PuzzleManager.puzzle_finished.connect(on_puzzle_finished)

func init_small_cards():
	for card in small_cards_parent.get_children():
		if card is Card:
			card.visible = false
			small_cards.append(card)
			
func init_big_cards():
	for card in big_cards_parent.get_children():
		if card is Card:
			card.visible = false
			big_cards.append(card)
			
func update_display():
	for card_index in range(small_cards.size()):
		if PuzzleManager.complete_puzzles[card_index] == true:
			small_cards[card_index].visible = true
			
func on_puzzle_finished(puzzle_index: int):
	small_cards[puzzle_index].fade_in()
	big_cards[puzzle_index].play_fade_sequence()
