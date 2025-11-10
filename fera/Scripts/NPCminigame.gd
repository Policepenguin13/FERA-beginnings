extends Area2D
# MINIGAME NPC: asks whether or not player wants to play minigame

# NPC: hi there player, would you like to play minigame?
# if yes:
# 	NPC: great, would you like me to explain how to play?
# 	if yes:
# 		NPC: here's how to play
# 	start minigame
# else (no):
# 	NPC: alright then

signal DanceMini
signal FlowerMini

@export var AskToPlay: Array[String] = [] # normal thing
@export var QuestGuide: Array[String] = [] # thing
# @export var EndgameStart: Array[String] = [] # main story complete start
@export var DontWantToPlay: Array[String] = [] # if they say no overall
@export var minigame: String = ""
@export var questMilestone: int = 0
@export var NotYet: Array[String] = []

var AskedToPlay = null
var YesToPlay = null
var AmIAsking = false

var previous: int

func _ready():
	reset()
	$"../../Player/Cam/UI/Yes".pressed.connect(_on_yes_pressed)
	$"../../Player/Cam/UI/No".pressed.connect(_on_no_pressed)
	%DialogueBox.DialogueEnded.connect(end)

func reset():
	AskedToPlay = null
	YesToPlay = null
	AmIAsking = false

func end():
	# print(str(self) + " notices that the dialogue has ended")
	if %DialogueBox.talker != self:
		# print("you aren't talking to " + str(self))
		return
	else:
		print("you are talking to " + str(self))
		if AskedToPlay == true:
			# it likes this structure
			if YesToPlay == false:
				print("refusal dialogue over, resetting")
				reset()

func Interact():
	$art.CheckDir()
	if minigame == "DANCE" and Globals.StoryMilestone < 3:
		%DialogueBox.choice = false
		%DialogueBox.Say(NotYet, self)
		reset()
	else:
		if AskedToPlay == true:
			# print(str(self) + " has asked if player would like to play")
			if YesToPlay == true:
				#print("player said they would like to play")
				# print("TRIGGER " + minigame + " MINIGAME HERE")
				if minigame == "DANCE":
					DanceMini.emit()
				elif minigame == "FLOWER":
					if Globals.BagOrder.has("Flower"):
						previous = Globals.BagAmounts["Flower"]
					FlowerMini.emit()
					monitorable = false
					monitoring = false
				# print(minigame + " minigame hasn't been coded yet, so have the reward anyway")
				# if minigame == "DANCE":
				# 	print("You dance with kim, hooray!")
				# 	Globals.ThreeDanced = true
				reset()
			else: 
				print("player said no i wouldn't like to play")
				# AmIAsking = true
				%DialogueBox.choice = false
				%DialogueBox.Say(DontWantToPlay, self)
				# await dialogueEnded to reset
		else:
			# print(str(self) + " has NOT asked if player wants to play")
			# AmIAsking = true
			%DialogueBox.choice = true
			%DialogueBox.Say(AskToPlay, self)

func _on_yes_pressed():
	#print("said yes")
	if %DialogueBox.talker != self:
		# print(str(self) + "is NOT asking")
		return
	else:
		# print(str(self) + "is asking")
		if YesToPlay == null:
			YesToPlay = true
	if AskedToPlay == null:
		AskedToPlay = true
	$"../../Player/Cam/UI/Yes".hide()
	$"../../Player/Cam/UI/No".hide()
	%DialogueBox.EndDialogue()
	Interact()

func _on_no_pressed():
	print("said no")
	if %DialogueBox.talker != self:
		print(str(self) + "is NOT asking")
		return
	else:
		print(str(self) + "is asking")
		if YesToPlay == null:
			YesToPlay = false
	if AskedToPlay == null:
		AskedToPlay = true
	$"../../Player/Cam/UI/Yes".hide()
	$"../../Player/Cam/UI/No".hide()
	# %DialogueBox.choice = false
	# %DialogueBox.Say(DontWantToPlay, self)
	# %DialogueBox.EndDialogue()
	# $"../../Player/interactStuff".AutoInteract()
	
	# Interact()
