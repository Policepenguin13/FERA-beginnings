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

func reset():
	AskedToPlay = null
	YesToPlay = null

func Interact():
	if AskedToPlay == true:
		#print("have asked if player would like to play")
		if YesToPlay == true:
			#print("player said they would like to play")
			print("TRIGGER " + minigame + " MINIGAME HERE")
			if minigame == "DANCE":
				Globals.danced = true
			if Globals.StoryMilestone == 4 and minigame == "FLOWER":
				print("as long as you get 1 more flower than you previously had, goal reached")
				Globals.FourGoals.append("flowers")
			reset()
		else: 
			#print("player said no i wouldn't like to play")
			%DialogueBox.choice = false
			%DialogueBox.Say(DontWantToPlay)
	else:
		# print("have not asked if player wants to play")
		%DialogueBox.choice = true
		%DialogueBox.Say(AskToPlay)

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

func EndedDialogue():
	if AskedToPlay == true:
#		print("have asked to play before")
		if YesToPlay == true:
			print("yes to play is true")
		else:
			print("yes to play is false")
			# reset()
	print("resetting variables")
	reset()
