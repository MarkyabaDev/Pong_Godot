extends Control

onready var title := $"%Title"
export(String) var mainMenuScene = "res://Scenes/MainMenu.tscn"

func _ready():
	visible = false
	Events.connect("game_end", self, "_on_game_end")

func _on_BackToMenuButton_pressed():
	get_tree().change_scene(mainMenuScene)

func _on_game_end(left_won: bool):
	if left_won:
		title.text = "Player 1 won"
	else:
		title.text = "Player 2 won"
		
	visible = true
