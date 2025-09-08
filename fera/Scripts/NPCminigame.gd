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

@export var AskToPlay: Array[String] = [] # normal thing
# @export var EndgameStart: Array[String] = [] # main story complete start
@export var DontWantToPlay: Array[String] = [] # if they say no overall
@export var minigame: String = ""

var AskedToPlay = null
var YesToPlay = null

func _ready():
	reset()
#	%DialogueBox.DialogueEnded.connect(EndedDialogue)
	$"../../Player/Cam/UI/Yes".pressed.connect(_on_yes_pressed)
	$"../../Player/Cam/UI/No".pressed.connect(_on_no_pressed)

func reset():
	AskedToPlay = null
	YesToPlay = null

func Interact():
	if AskedToPlay == true:
		#print("have asked if player would like to play")
		if YesToPlay == true:
			#print("player said they would like to play")
			print("TRIGGER " + minigame + " MINIGAME HERE")
			print(minigame + " minigame hasn't been coded yet, so have the reward anyway")
			if minigame == "DANCE":
				Globals.ThreeDanced = true
			else:
				print("giving you 10 flowers")
				%inventory.AddItem("Flower")# 1
				%inventory.AddItem("Flower")# 2
				%inventory.AddItem("Flower")# 3
				%inventory.AddItem("Flower")# 4
				%inventory.AddItem("Flower")# 5
				%inventory.AddItem("Flower")# 6
				%inventory.AddItem("Flower")# 7
				%inventory.AddItem("Flower")# 8
				%inventory.AddItem("Flower")# 9
				%inventory.AddItem("Flower")# 10
			if Globals.StoryMilestone == 4 and minigame == "FLOWER":
				print("as long as you get 1 more flower than you previously had, goal reached")
				Globals.FourGoals.append("flowers")
			reset()
		else: 
			#print("player said no i wouldn't like to play")
			%DialogueBox.choice = false
			%DialogueBox.Say(DontWantToPlay, self)
	else:
		# print("have not asked if player wants to play")
		%DialogueBox.choice = true
		%DialogueBox.Say(AskToPlay, self)

func _on_yes_pressed():
	#print("said yes")
	if YesToPlay == null:
		YesToPlay = true
	BothButtonPress()

func _on_no_pressed():
	#print("said no")
	if YesToPlay == null:
		YesToPlay = false
	BothButtonPress()

func BothButtonPress():
	%DialogueBox.EndDialogue()
	if AskedToPlay == null:
		AskedToPlay = true

	Interact()
	$"../../Player/Cam/UI/Yes".hide()
	$"../../Player/Cam/UI/No".hide()
