extends Area2D
# COMPLEX INTERACTABLE: says lots of different stuff depending on
# several variables

@export var Default: Array[String] = [] # if all else fails
@export var ZeroTetoIntro: Array[String] = []
@export_group("One")
@export var OneNoFood: Array[String] = []
@export var OneFoodBite: Array[String] = []
@export_group("Two")
@export var TwoNoFood: Array[String] = []
@export var TwoFood: Array[String] = []
@export_group("Three")
@export var ThreeNotDanced: Array[String] = []
@export var ThreeDancedName: Array[String] = []
@export var ThreeGoAskMum: Array[String] = []
@export_group("Four")
@export var FourNone: Array[String] = []
@export var FourFlowers: Array[String] = []
@export var FourWater: Array[String] = []
@export var FourToy: Array[String] = []
@export var FourFollow: Array[String] = []
@export_group("Five")
@export var Five: Array[String] = []

var FourCutscenesShown: Array[String] = []
signal MumCutscene

func _ready():
	%DialogueBox.DialogueEnded.connect(end)

func end():
	# print("burrow notices that the dialogue has ended")
	if %DialogueBox.talker != self:
		# print("but you are not talking to burrow")
		pass
	else:
		# print("you were talking to burrow!")
		if %DialogueBox.RawWords == ZeroTetoIntro:
			# print("zero teto intro, +1 story milestone")
			Globals.StoryMilestone += 1
		elif %DialogueBox.RawWords == OneFoodBite:
			# print("just said one food bite cutscene, get storymilestone from mum")
			%inventory.RemoveItem("Sausage Roll")
			$"../../Player".Teleport(Vector2(728,104), "RIGHT")
			MumCutscene.emit()
			print("burrow emitting mum cutscene")
			# Globals.StoryMilestone += 1
			# %DialogueBox.cutscene = false
			# $"../../Player/interactStuff".interactable = $"../Mum"
			# $"../Mum".CutsceneTime = true
			
			
		elif %DialogueBox.RawWords == TwoFood:
			# print("just said two food, remove 1 sausage from inventory, +1 story milestone")
			Globals.StoryMilestone += 1
			%inventory.RemoveItem("Sausage Roll")
			
		elif %DialogueBox.RawWords == ThreeDancedName:
			# print("just said three danced name, go talk to mum for story milestone")
			Globals.ThreeNameHappened = true
			
		elif %DialogueBox.RawWords == FourFlowers:
			# print("just said four flowers, remove 1 flower from inventory")
			%inventory.RemoveItem("Flower")
			FourCutscenesShown.append("Flower")
			
		elif %DialogueBox.RawWords == FourWater:
			# print("just said four water, remove 1 water bowl from inventory")
			%inventory.RemoveItem("Water Bowl")
			%inventory.AddItem("Bowl")
			FourCutscenesShown.append("Water")
			
		elif %DialogueBox.RawWords == FourToy:
			# print("just said one four toy, remove 1 toy from inventory")
			# %inventory.RemoveItem("Toy")
			FourCutscenesShown.append("Toy")
			
		elif %DialogueBox.RawWords == FourFollow:
			# print("just said four follow, +1 story milestone")
			Globals.StoryMilestone += 1
		else:
			pass
			# print("no change needed as a result of dialogue")
	

func Interact():
	# CHECK STORY STUFF HERE.
	if Globals.StoryMilestone == 0:
		# print("doing bite cutscene instead of tetoIntro")
		%Cutscenes.BiteCutscene()
		%DialogueBox.cutscene = true
		%DialogueBox.Say(OneFoodBite, self)
		#%DialogueBox.Say(ZeroTetoIntro, self)
		# print("TETO INTRO CUTSCENE TRIGGER")
	elif Globals.StoryMilestone == 1:
		if Globals.BagOrder.has("Sausage Roll"):
			%Cutscenes.BiteCutscene()
			%DialogueBox.cutscene = true
			%DialogueBox.Say(OneFoodBite, self)
			# print("BITE CUTSCENE TRIGGER, also remove sausage")
		else:
			%DialogueBox.Say(OneNoFood, self)
	
	elif Globals.StoryMilestone == 2:
		if Globals.BagOrder.has("Sausage Roll"):
			%Cutscenes.DragCutscene()
			%DialogueBox.cutscene = true
			%DialogueBox.Say(TwoFood, self)
		else:
			%DialogueBox.Say(TwoNoFood, self)
	
	elif Globals.StoryMilestone == 3:
		if Globals.ThreeDanced:
			if !Globals.ThreeNameHappened:
				%Cutscenes.FriendCutscene()
				%DialogueBox.cutscene = true
				%DialogueBox.Say(ThreeDancedName, self)
				# print("TRIGGER FRIEND (and then name) CUTSCENE")
			else:
				%DialogueBox.Say(ThreeGoAskMum, self)
		else:
			%DialogueBox.Say(ThreeNotDanced, self)
	
	elif Globals.StoryMilestone == 4:
		if FourCutscenesShown.size() == 3:
			%DialogueBox.Say(FourFollow, self)
			print("FOLLOW CUTSCENE TRIGGER")
			
		elif Globals.FourGoals.has("Toy") and !FourCutscenesShown.has("Toy"):
			%Cutscenes.ToyCutscene()
			%DialogueBox.cutscene = true
			%DialogueBox.Say(FourToy, self)
			print("TRIGGER TOY CUTSCENE")
			
		elif Globals.FourGoals.has("Flower") and !FourCutscenesShown.has("Flower"):
			%Cutscenes.SneezeCutscene()
			%DialogueBox.cutscene = true
			%DialogueBox.Say(FourFlowers, self)
			print("TRIGGER SNEEZE CUTSCENE")
			
		elif Globals.FourGoals.has("Water") and !FourCutscenesShown.has("Water"):
			%Cutscenes.SplashCutscene()
			%DialogueBox.cutscene = true
			%DialogueBox.Say(FourWater, self)
			print("TRIGGER SPLASH CUTSCENE")
			
		else:
			%DialogueBox.Say(FourNone, self)
	
	elif Globals.StoryMilestone == 5 or Globals.StoryMilestone == 6:
		%DialogueBox.Say(Five, self)
	else:
		%DialogueBox.Say(Default, self)
	
# 0 (TUTORIAL)
# - int w/ burrow, teto intro cutscene
# 1 (FOOD) 
#		. go to shopkeep, get sausage
# - int w/ burrow when you have a sausage, bite cutscene
# 2 (APOLOGY SAUSAGE + FLOWERS)
#		. go to shopkeep, he says "go get flowers"
#		. get flowers via minigame
#		. back to shopkeep, get sausage
# - int w/ burrow when you have sausage and flowers
# 3 (MUSIC REFERENCE HERE)
#		. dance minigame
# - int w/ burrow once you've danced, name cutscene
# 4 (WATER, FLOWER, TOY, IN ANY ORDER)
#		flower
#			.get flowers via minigame
#			.back to burrow, sneeze cutscene
#		water
#			.interact with pump (maybe 3 times, maybe timing minigame)
#			.back to burrow, splash cutscene
#		toy
#			.interact with timmy
#			.back to burrow, toy cutscene
# - after the last flower/water/toy cutscene, follow cutscene!
# 5 (JUST BEFORE THE END)
#		.int w/ mum
#		.optionally do other stuff
# - walk to trail 01
# 6 (THE END), you completed the game!
