extends Control

export(String) var mainGameScene: String = "res://Scenes/GameWorld.tscn"

onready var titleScreenContainer := $"%TitleScreenContainer"
onready var difficultyContainer := $"%DifficultyContainer"

func _ready():
	VisualServer.set_default_clear_color(Color.black)

func _on_StartButton_pressed():
	difficultyContainer.visible = true
	titleScreenContainer.visible = false

func _on_QuitButton_pressed():
	get_tree().quit()


func _on_EasyButton_pressed():
	startGame(Globals.Difficulty.EASY)
	pass # Replace with function body.

func _on_MediumButton_pressed():
	startGame(Globals.Difficulty.MEDIUM)


func _on_HardButton_pressed():
	startGame(Globals.Difficulty.HARD)


func _on_BackButton_pressed():
	difficultyContainer.visible = false
	titleScreenContainer.visible = true

func startGame(difficulty):
	Globals.difficulty = difficulty
	get_tree().change_scene(mainGameScene)
