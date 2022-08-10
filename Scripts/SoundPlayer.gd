extends Node

const BUMP_BORDER = preload("res://Sounds/bump_border.wav")
const BUMP_PALLET = preload("res://Sounds/bump_pallet.wav")
const GOAL = preload("res://Sounds/goal.wav")
onready var audioPlayers: Node = $AudioPlayers

func playSound(sound: AudioStream):
	for audioPlayer in audioPlayers.get_children():
		audioPlayer = audioPlayer as AudioStreamPlayer
		if !audioPlayer.playing:
			audioPlayer.stream = sound
			audioPlayer.play()
			return
		
