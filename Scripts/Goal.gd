extends Area2D

func _on_Goal_body_entered(body: Node):
	if body is Ball:
		SoundPlayer.playSound(SoundPlayer.GOAL)
		body.reset()
		Events.emit_signal("ball_entered_goal", body.direction)
