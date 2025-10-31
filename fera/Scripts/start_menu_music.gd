extends Node

var playing

# Called when the node enters the scene tree for the first time.
func _ready():
	for child in get_children():
		if !child.finished.is_connected(NextTrack):
			child.finished.connect(NextTrack)
		child.volume_db = 0.0
	print("MENU music is set up")
	NextTrack()
	if !%"Start Menu".MusicFade.is_connected(Fade):
		%"Start Menu".MusicFade.connect(Fade)
	playing.stream_paused = false

func NextTrack():
	playing = get_children().pick_random()
	playing.play()
	print("MENU now playing... " + playing.name)

func Fade():
	print("MENU is fading out")
	var fader = get_tree().create_tween()
	fader.tween_property(playing, "volume_db", -80.0, 1.5)
	playing.stream_paused = true
