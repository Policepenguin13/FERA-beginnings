extends Node2D
@onready var dance = load("res://Scenes/dance_minigame.tscn")

signal GetToMenu

func pause():
	process_mode = PROCESS_MODE_DISABLED

func unpause():
	process_mode = PROCESS_MODE_INHERIT
	
# Called when the node enters the scene tree for the first time.
func _ready():
	print("pausing " + self.name)
	$Player/Cam.enabled = false
	pause()
	
func Ready():
	print("no longer paused")
	process_mode = PROCESS_MODE_INHERIT
	$Player/Cam.enabled = true
	if !$NPCs/DanceInstructor.DanceMini.is_connected(triggerDance):
		$NPCs/DanceInstructor.DanceMini.connect(triggerDance)
	if !$NPCs/FloristFlora.FlowerMini.is_connected(triggerFlower):
		$NPCs/FloristFlora.FlowerMini.connect(triggerFlower)
	if !$DanceMinigame.DanceOver.is_connected(EndDance):
		$DanceMinigame.DanceOver.connect(EndDance)
	if !$FlowerMinigame.FlowerEnded.is_connected(EndFlower):
		$FlowerMinigame.FlowerEnded.connect(EndFlower)
	if !$Player/Cam/UI/menu.QuitToMenu.is_connected(ToMenu):
		$Player/Cam/UI/menu.QuitToMenu.connect(ToMenu)
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
	
	$Player/Cam/UI/Ask.Ready()

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
	# print("flower ended")
	$FlowerMinigame/Cam.enabled = false
	$Player/Cam.enabled = true
	for child in self.get_children():
		if child.is_class("CanvasItem"):
			if child != $FlowerMinigame:
				child.show()
		else:
			for kid in child.get_children():
				kid.show()
	$FlowerMinigame.hide()
	var bob
	if Globals.BagOrder.has("Flower"):
		bob = Globals.BagAmounts["Flower"]
	else:
		bob = 0
	var number = 0
	while number != $FlowerMinigame.score:
		number+=1
		%inventory.AddItem("Flower")
		# print(number)
	Globals.CanMove = true
	if Globals.StoryMilestone == 4 and !Globals.FourGoals.has("Flower"):
		if bob < number:
			Globals.FourGoals.append("Flower")
	
func ToMenu():
	print("To menu!!")
	pause()
