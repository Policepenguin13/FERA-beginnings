extends Node

var playing
var fading
# var NormalTracks = ["TheJourney","DefinitelyOurTown","BannersInTheWind"]
# var CutsceneTracks = ["FantasyDragon","WhereTheWindsRoam"]
# var ViableTracks = []
var bus_index: int

# Called when the node enters the scene tree for the first time.
func _ready():
	await NextTrack()
	FadeIn()
	bus_index = AudioServer.get_bus_index("Background")
	for child in get_children():
		if !child.finished.is_connected(Done):
			child.finished.connect(Done)
	# print("GAME music is set up")
# 	ViableTracks = NormalTracks
	# if !%Cutscenes.CutsceneStarted.is_connected(ToCutscene):
	# 	%Cutscenes.CutsceneStarted.connect(ToCutscene)
	# if !%DialogueBox.DialogueEnded.is_connected(ToBg):
	# 	%DialogueBox.DialogueEnded.connect(ToBg)

func NextTrack():
	if playing != null:
		# print("something is already playing")
		return
	playing = get_children().pick_random()
	playing.play()
	# print("Now playing... " + playing.name)
	# if ViableTracks.has(playing.name):
	# 	playing.play()
	# 	print("GAME now playing... " + playing.name)
	# else:
	# 	print(playing.name + " is not in ViableTracks (" + str(ViableTracks) + "), picking again...")
	# 	NextTrack()

func Done():
	# print(playing.name + " is done")
	playing = null
	NextTrack()

func FadeOut():
	# print(name+ "fading out")
	# playing.volume_db = 
	var fader = get_tree().create_tween()
	fader.tween_property(playing, "volume_db", linear_to_db(0.001), 1.0).from(AudioServer.get_bus_volume_db(bus_index))
	await fader.finished
	playing.stop()
	playing.stream_paused = true
	playing = null

func FadeIn():
	if fading == true:
		return
	# print(name+" fading in")
	playing.stream_paused = false
	# print("GAME is fading in")
	# print("fading in from " + str(linear_to_db(0.001)) + " TO " + str(AudioServer.get_bus_volume_db(bus_index)))
	fading = true
	var fader = get_tree().create_tween()
	playing.volume_db = linear_to_db(0.001)
	fader.tween_property(playing, "volume_db", AudioServer.get_bus_volume_db(bus_index), 2.0).from(linear_to_db(0.001))
	await fader.finished
	fading = false
# func ToCutscene():
	
# 	ViableTracks = CutsceneTracks
# 	if !ViableTracks.has(playing.name):
# 		print("GAME swapping to cutscene music")
# 		FadeOut()
# 		NextTrack()
# 		FadeIn()

# func ToBg():
# 	if %DialogueBox.cutscene == true and Globals.talking == false:
# 		print("GAME swapping to background music")
# 		ViableTracks = NormalTracks
# 	if !ViableTracks.has(playing.name):
# 		FadeOut()
# 		NextTrack()
# 		FadeIn()
