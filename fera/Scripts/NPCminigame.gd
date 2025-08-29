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
@export var AskHowToPlay: Array[String] = []
@export var HowToPlay: Array[String] = []
@export var minigame: String = ""

var AskedToPlay = false
var AskedInstructions = false
var YesToPlay = false
var YesToInstructions = false
var SaidInstructions = false

func _ready():
	reset()

func reset():
	AskedToPlay = false
	AskedInstructions = false
	YesToPlay = false
	YesToInstructions = false

func Interact():
	if AskedToPlay:
		print("have asked if player would like to play")
		if YesToPlay:
			print("player said they would like to play")
			if AskedInstructions:
				print("have asked if player wants explanation how2play")
				if SaidInstructions:
					print("already explained how2play")
					print("TRIGGER " + minigame + " MINIGAME")
				else:
					print("haven't explained how2play")
					if YesToInstructions: 
						print("player would like explanation how2play")
						%DialogueBox.Say(HowToPlay)
					else: 
						print("player wouldn't like explanation how 2 play")
						print("TRIGGER " + minigame + " MINIGAME")
			else: #
				print("haven't asked if player knows how 2 play")
				%DialogueBox.choice = true
				%DialogueBox.Say(AskHowToPlay)
		else: 
			print("player said no i wouldn't like to play")
			%DialogueBox.Say(DontWantToPlay)
	else:
		print("have not asked if player wants to play")
		%DialogueBox.choice = true
		%DialogueBox.Say(AskToPlay)

func _on_yes_pressed():
	print("said yes")

func _on_no_pressed():
	print("said no")
