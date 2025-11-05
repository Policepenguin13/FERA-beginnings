extends Node

var playing

# Called when the node enters the scene tree for the first time.
func _ready():
	for child in get_children():
		if !child.finished.is_connected(NextTrack):
			child.finished.connect(NextTrack)
		child.volume_db = linear_to_db(%bgBar.value)
	# print("MENU music is set up")
	NextTrack()
	
	if !%"Start Menu".MusicFade.is_connected(FadeOut):
		%"Start Menu".MusicFade.connect(FadeOut)
	playing.stream_paused = false
	FadeIn()

func NextTrack():
	playing = get_children().pick_random()
	playing.play()
	# print("MENU now playing... " + playing.name)

func FadeOut():
	print("MENU fading out")
	playing.volume_db = linear_to_db(%bgBar.value)
	# AudioServer.set_bus_volume_db(bus_index, linear_to_db(-80.0))
	var fader = get_tree().create_tween()
	fader.tween_property(playing, "volume_db", linear_to_db(%bgBar.min_value), 2.0).from(linear_to_db(%bgBar.value))
	playing.stream_paused = true
	playing.stop()

func FadeIn():
	print("MENU fading in")
	playing.stream_paused = false
	# print("GAME is fading in")
	print("fading in from " + str(linear_to_db(%bgBar.min_value)) + " TO " + str(linear_to_db(%bgBar.value)))
	var fader = get_tree().create_tween()
	playing.volume_db = linear_to_db(%bgBar.min_value)
	fader.tween_property(playing, "volume_db", linear_to_db(%bgBar.value), 2.0).from(linear_to_db(%bgBar.min_value))
