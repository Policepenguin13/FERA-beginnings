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
	$FlowerMinigame.FlowerEnded.connect(EndFlower)
	# triggerDance()
	$Player/Cam.enabled = true
	for child in self.get_children():
		if child.is_class("CanvasItem"):
			if child != $DanceMinigame or child != $FlowerMinigame:
				child.show()
		else:
			for kid in child.get_children():
				kid.show()
	$FlowerMinigame.hide()
	$DanceMinigame.hide()

func triggerDance():
	print("trigger dance")
	for child in self.get_children():
		if child != $DanceMinigame:
			if child.is_class("CanvasItem"):
				child.hide()
			else:
				for kid in child.get_children():
					kid.hide()
	$DanceMinigame.show()
	Globals.CanMove = false
	$DanceMinigame.Ready()
	$DanceMinigame/Cam.enabled = true
	$Player/Cam.enabled =  false

func triggerFlower():
	print("trigger flower")
	for child in self.get_children():
		if child != $FlowerMinigame:
			if child.is_class("CanvasItem"):
				child.hide()
			else:
				for kid in child.get_children():
					kid.hide()
	Globals.CanMove = false
	$FlowerMinigame.Ready()
	$FlowerMinigame.show()
	$FlowerMinigame/Cam.enabled = true
	$Player/Cam.enabled =  false

func EndDance():
	print("dance ended")
	$DanceMinigame/Cam.enabled = false
	$Player/Cam.enabled = true
	for child in self.get_children():
		if child.is_class("CanvasItem"):
			if child != $DanceMinigame:
				child.show()
		else:
			for kid in child.get_children():
				kid.show()
	$FlowerMinigame.hide()
	Globals.CanMove = true
	if Globals.StoryMilestone == 3:
		Globals.ThreeDanced = true

func EndFlower():
	print("flower ended")
	$FlowerMinigame/Cam.enabled = false
	$Player/Cam.enabled = true
	for child in self.get_children():
		if child.is_class("CanvasItem"):
			if child != $FlowerMinigame:
				child.show()
		else:
			for kid in child.get_children():
				kid.hide()
	$FlowerMinigame.hide()
	var number = 0
	while number != $FlowerMinigame.score:
		number+=1
		%inventory.AddItem("Flower")
		# print(number)
	Globals.CanMove = true
	
