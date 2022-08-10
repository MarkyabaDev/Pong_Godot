extends KinematicBody2D

class_name Ball

export(Resource) onready var ballData = ballData as BallDataResource

onready var startTimer: Timer = $StartTimer

var direction = Globals.Directions.LEFT setget set_direction

var running: bool = false setget set_running
var velocity: Vector2 = Vector2.ZERO
var initialPosition: Vector2 = Vector2.ZERO
var rng: RandomNumberGenerator = RandomNumberGenerator.new()
var speed: float

func _ready():
	startStartTimer()
	speed = ballData.initialSpeed
	initialPosition = global_position

func _physics_process(delta:float) -> void:
	if !running || Globals.gamePaused || Globals.gameEnd:
		return
	
	velocity.x = direction * speed * delta
	
	var collision: KinematicCollision2D = move_and_collide(velocity)
	if collision != null:
		if collision.collider is Pallet:
			switchDirection(delta)
			return
		
		SoundPlayer.playSound(SoundPlayer.BUMP_BORDER)
		velocity.y *= -1
	
	Globals.ballPosition = global_position
	
func _on_StartTimer_timeout():
	self.running = true
	
func set_running(value):
	running = value
	Events.emit_signal("change_ball_state", value)
	
func set_direction(value):
	direction = value
	Events.emit_signal("change_ball_direction", value)
	
func switchDirection(delta: float):
	SoundPlayer.playSound(SoundPlayer.BUMP_PALLET)
	match direction:
		Globals.Directions.LEFT: self.direction = Globals.Directions.RIGHT
		Globals.Directions.RIGHT: self.direction = Globals.Directions.LEFT
		
	rng.randomize()
	var randomXVelocity = rng.randf_range(-ballData.rangeOfRandomXVelocity, ballData.rangeOfRandomXVelocity)
	velocity.y = randomXVelocity * delta
	speed += ballData.speedIncreaseValue
	if speed > ballData.maximumSpeed:
		speed = ballData.maximumSpeed
		
func startStartTimer() -> void:
	self.running = false
	startTimer.start(ballData.waitTimeInSeconds)
	
func reset():
	global_position = initialPosition
	velocity = Vector2.ZERO
	speed = ballData.initialSpeed
	startStartTimer()
