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

var SaidBiteYet = false

func _ready():
	%DialogueBox.DialogueEnded.connect(end)
	SaidYouCanGo = false
	SaidBiteYet = false
	$"../Burrow".MumCutscene.connect(cut)

func cut():
	# print("MUM: cutscene called")
	CutsceneTime = true
	await get_tree().create_timer(0.05).timeout
	# print("MUM: physics might have readjusted now")
	# $"../../Player/interactStuff".InteractLost($"../../Player/interactStuff".interactable)
	# $"../../Player/interactStuff".InteractFound(self)
	$"../../Player/interactStuff".AutoInteract()

func end():
	# print("burrow notices that the dialogue has ended")
	if %DialogueBox.talker != self:
		# print("but you are not talking to burrow")
		return
	else:
		# print("END CALLED WHEN TALKER WAS MUM")
		if %DialogueBox.RawWords == OneBite:
			if SaidBiteYet:
				CutsceneTime = false
				# print("MUM said oneBite, +1 story milestone")
				Globals.StoryMilestone = 2
		if %DialogueBox.RawWords == ThreeLikes:
			print("+1 story milestone from mum")
			Globals.StoryMilestone += 1
			%inventory.AddItem("Bowl")
		if Globals.StoryMilestone == 5 and %DialogueBox.RawWords == FiveCanGo:
			SaidYouCanGo = true
			Globals.funds += 500
			%inventory.AddItem("Capture Crystal")
			%inventory.AddItem("Capture Crystal")
			%inventory.AddItem("Capture Crystal")
			%inventory.AddItem("Capture Crystal")
			%inventory.AddItem("Capture Crystal")

func Interact():
	$art.CheckDir()
	# print("interact w/ mum")
	if CutsceneTime:
		%DialogueBox.Say(OneBite, self)
		# print("said onebite / triggered saying onebite")
		SaidBiteYet = true
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
