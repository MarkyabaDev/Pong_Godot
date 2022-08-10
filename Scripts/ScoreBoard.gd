extends Control

export var scoreArray = [
	preload("res://Resources/ScoreTextures/Score_0.tres"),
	preload("res://Resources/ScoreTextures/Score_1.tres"),
	preload("res://Resources/ScoreTextures/Score_2.tres"),
	preload("res://Resources/ScoreTextures/Score_3.tres"),
	preload("res://Resources/ScoreTextures/Score_4.tres"),
	preload("res://Resources/ScoreTextures/Score_5.tres"),
	preload("res://Resources/ScoreTextures/Score_6.tres"),
	preload("res://Resources/ScoreTextures/Score_7.tres"),
	preload("res://Resources/ScoreTextures/Score_8.tres"),
	preload("res://Resources/ScoreTextures/Score_9.tres"),
	preload("res://Resources/ScoreTextures/Score_10.tres")
]

onready var score1 := $"%Score1"
onready var score2 := $"%Score2"

func _ready():
	Events.connect("left_got_point", self, "_on_left_got_point")
	Events.connect("right_got_point", self, "_on_right_got_point")
	
func _on_left_got_point():
	if Globals.score1 < len(scoreArray):
		score1.texture = scoreArray[Globals.score1]
	
func _on_right_got_point():
	if Globals.score2 < len(scoreArray):
		score2.texture = scoreArray[Globals.score2]
