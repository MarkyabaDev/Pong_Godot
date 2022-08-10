extends Node

enum Directions {LEFT = -1, RIGHT = 1}
enum Difficulty {EASY, MEDIUM, HARD}

var ballPosition: Vector2
var gamePaused: bool = false
var gameEnd: bool = false
var difficulty = Difficulty.EASY

var score1: int = 0 setget set_score1
var score2: int = 0 setget set_score2

func _ready():
	Events.connect("ball_entered_goal", self, "_on_ball_entered_goal")

func _on_ball_entered_goal(direction):
	match direction:
		Directions.LEFT: self.score2 += 1
		Directions.RIGHT: self.score1 += 1
		
func set_score1(value: int):
	score1 = value
	Events.emit_signal("left_got_point")
	if score1 >= 10:
		Events.emit_signal("game_end", true)
		gameEnd = true
	
func set_score2(value: int):
	score2 = value
	Events.emit_signal("right_got_point")
	if score2 >= 10:
		Events.emit_signal("game_end", false)
		gameEnd = true

func reset():
	score1 = 0
	score2 = 0
	gameEnd = false
	gamePaused = false
