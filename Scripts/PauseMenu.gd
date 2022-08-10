extends Control

export(String) var mainMenuScene = "res://Scenes/MainMenu.tscn"

func _ready():
	Events.connect("pause_game", self, "_on_pause_game")
	visible = false

func _on_ResumeButton_pressed():
	Events.emit_signal("pause_game", false)


func _on_BackToMenuButton_pressed():
	get_tree().change_scene(mainMenuScene)

func _on_pause_game(paused: bool):
	visible = paused
	Globals.gamePaused = paused
