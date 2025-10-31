extends Node

var playing
var NormalTracks = ["TheJourney","DefinitelyOurTown","BannersInTheWind"]
var CutsceneTracks = ["FantasyDragon","WhereTheWindsRoam"]
var ViableTracks = []
var bus_index: int

# Called when the node enters the scene tree for the first time.
func _ready():
	for child in get_children():
		if !child.finished.is_connected(NextTrack):
			child.finished.connect(NextTrack)
		child.volume_db = 0.0
	print("GAME music is set up")
	ViableTracks = NormalTracks
	NextTrack()
	FadeIn()
	if !%Cutscenes.CutsceneStarted.is_connected(ToCutscene):
		%Cutscenes.CutsceneStarted.connect(ToCutscene)
	if !%DialogueBox.DialogueEnded.is_connected(ToBg):
		%DialogueBox.DialogueEnded.connect(ToBg)
	bus_index = AudioServer.get_bus_index("Background")
	

func NextTrack():
	playing = get_children().pick_random()
	if ViableTracks.has(playing.name):
		playing.play()
		print("GAME now playing... " + playing.name)
	else:
		print(playing.name + " is not in ViableTracks (" + str(ViableTracks) + "), picking again...")
		NextTrack()
	

func FadeOut():
	print("GAME is fading out")
	var fader = get_tree().create_tween()
	playing.volume_db = 0.0
	# AudioServer.set_bus_volume_db(bus_index, linear_to_db(-80.0))
	fader.tween_property(playing, "volume_db", -80.0, 1.5)

func FadeIn():
	print("GAME is fading in")
	var fader = get_tree().create_tween()
	playing.volume_db = -80.0
	fader.tween_property(playing, "volume_db", 0.0, 1.5)

func ToCutscene():
	
	ViableTracks = CutsceneTracks
	if !ViableTracks.has(playing.name):
		print("GAME swapping to cutscene music")
		FadeOut()
		NextTrack()
		FadeIn()

func ToBg():
	if %DialogueBox.cutscene == true and Globals.talking == false:
		print("GAME swapping to background music")
		ViableTracks = NormalTracks
	if !ViableTracks.has(playing.name):
		FadeOut()
		NextTrack()
		FadeIn()
