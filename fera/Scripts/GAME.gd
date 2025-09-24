extends Node2D
@onready var dance = load("res://Scenes/dance_minigame.tscn")

func pause():
	process_mode = PROCESS_MODE_DISABLED

func unpause():
	process_mode = PROCESS_MODE_INHERIT
	
# Called when the node enters the scene tree for the first time.
func _ready():
	$NPCs/DanceInstructor.DanceMini.connect(triggerDance)
	$NPCs/FloristFlora.FlowerMini.connect(triggerFlower)
	$DanceMinigame.DanceOver.connect(EndDance)
	# triggerDance()
	$Player/Cam.enabled = true
	for child in self.get_children():
		if child.is_class("CanvasItem"):
			if child != $DanceMinigame:
				child.show()

func triggerDance():
	print("trigger dance")
	for child in self.get_children():
		if child != $DanceMinigame:
			if child.is_class("CanvasItem"):
				child.hide()
	Globals.CanMove = false
	$DanceMinigame.Ready()
	$DanceMinigame/Cam.enabled = true
	$Player/Cam.enabled =  false

func triggerFlower():
	print("trigger flower")

func EndDance():
	print("dance ended")
	$DanceMinigame/Cam.enabled = false
	$Player/Cam.enabled = true
	for child in self.get_children():
		if child.is_class("CanvasItem"):
			if child != $DanceMinigame:
				child.show()
	Globals.CanMove = true
	if Globals.StoryMilestone == 3:
		Globals.ThreeDanced = true
