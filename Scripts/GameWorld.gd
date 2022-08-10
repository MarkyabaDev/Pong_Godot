extends Node2D

class_name GameWorld

func _ready():
	VisualServer.set_default_clear_color(Color.black)
	Globals.reset()
	
func _process(delta):
	if Input.is_action_just_pressed("ui_cancel") && !Globals.gameEnd:
		Globals.gamePaused = !Globals.gamePaused
		Events.emit_signal("pause_game", Globals.gamePaused)
