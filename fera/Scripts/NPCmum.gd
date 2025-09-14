extends Area2D
#{player}: *sniffle* ...And then they bit me! I was only trying to be their friend!
#MUM: The Fera was feeling scared and threatened,
#MUM: They didn't mean to hurt you, just like you didn't mean to scare them.

@export var Default: Array[String] = [] # if all else fails
@export var OneBite: Array[String] = []
@export var ThreeLikes: Array[String] = []
@export var FiveCanGo: Array[String] = []
@export var Five: Array[String] = []

var CutsceneTime = false
var SaidYouCanGo = false

func _ready():
	%DialogueBox.DialogueEnded.connect(end)
	SaidYouCanGo = false

func end():
	# print("burrow notices that the dialogue has ended")
	if %DialogueBox.talker != self:
		# print("but you are not talking to burrow")
		return
	else:
		# print("you're talking to " + str(self))
		if Globals.StoryMilestone == 1 and CutsceneTime:
			CutsceneTime = false
			print()
			Globals.StoryMilestone += 1
		if Globals.StoryMilestone == 3 and Globals.ThreeNameHappened:
			print("+1 story milestone from mum")
			Globals.StoryMilestone += 1
			%inventory.AddItem("Bowl")
		if Globals.StoryMilestone == 5 and %DialogueBox.RawWords == FiveCanGo:
			SaidYouCanGo = true

func Interact():
	# print("interact w/ mum")
	if CutsceneTime:
		%DialogueBox.Say(OneBite, self)
	elif Globals.StoryMilestone == 3:
		if Globals.ThreeNameHappened:
			%DialogueBox.Say(ThreeLikes, self)
		else:
			%DialogueBox.Say(Default, self)
	elif Globals.StoryMilestone <= 4:
		%DialogueBox.Say(Default, self)
	elif Globals.StoryMilestone >= 5:
		if SaidYouCanGo:
			%DialogueBox.Say(Five, self)
		else:
			%DialogueBox.Say(FiveCanGo, self)
	
