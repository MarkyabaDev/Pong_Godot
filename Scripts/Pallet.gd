extends KinematicBody2D

class_name Pallet

export(Globals.Directions) var direction = Globals.Directions.LEFT

export(Resource) var palletData = palletData as PalletData

onready var easyModeData := preload("res://Resources/EasyPalletData.tres")
onready var mediumModeData := preload("res://Resources/MediumPalletData.tres")
onready var hardModeData := preload("res://Resources/HardPalletData.tres")

var velocity: Vector2
var initialPosition: Vector2
var ballActive: bool = false
var ballDirection

func _ready() -> void:
	initialPosition = global_position
	if !palletData.isPlayer:
		match Globals.difficulty:
			Globals.Difficulty.EASY: palletData = easyModeData
			Globals.Difficulty.MEDIUM: palletData = mediumModeData
			Globals.Difficulty.HARD: palletData = hardModeData
		Events.connect("change_ball_state", self, "_on_ball_active_changed")
		Events.connect("change_ball_direction", self, "_on_ball_direction_changed")

func _physics_process(delta: float) -> void:
	if Globals.gamePaused || Globals.gameEnd:
		return
	global_position.x = initialPosition.x
	if palletData.isPlayer:
		playerInput()
	else:
		AIMovement()
		
	velocity = move_and_slide(velocity)

func playerInput() -> void:
	velocity.y = Input.get_axis("ui_up", "ui_down") * palletData.speed

func AIMovement() -> void:
	var targetPosition: Vector2 = Vector2(global_position.x, Globals.ballPosition.y)
	var targetDirection: Vector2 = global_position.direction_to(targetPosition).normalized()

	if ballDirection != direction || !ballActive:
		targetDirection = global_position.direction_to(initialPosition)
	
	velocity.y = targetDirection.y * palletData.speed

func _on_ball_active_changed(active: bool) -> void:
	ballActive = active

func _on_ball_direction_changed(direction) -> void:
	ballDirection = direction
